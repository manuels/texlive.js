--
-- This is file `pgfmolbio.chromatogram.lua',
-- generated with the docstrip utility.
--
-- The original source files were:
--
-- pgfmolbio.dtx  (with options: `pmb-chr-lua')
--
-- Copyright (C) 2011 by Wolfgang Skala
--
-- This work may be distributed and/or modified under the
-- conditions of the LaTeX Project Public License, either version 1.3
-- of this license or (at your option) any later version.
-- The latest version of this license is in
--   http://www.latex-project.org/lppl.txt
-- and version 1.3 or later is part of all distributions of LaTeX
-- version 2005/12/01 or later.
--
module("pgfmolbio.chromatogram", package.seeall)

local ALL_BASES = {"A", "C", "G", "T"}
local PGFKEYS_PATH = "/pgfmolbio/chromatogram/"

local header, samples,
  peaks, parms,
  selectedPeaks,
  lastScfFile

local function baseToSampleIndex (baseIndex)
  local result = tonumber(baseIndex)
  if result then
    return result
  else
    result = string.match(baseIndex, "base%s*(%d+)")
    if tonumber(result) then
      return peaks[tonumber(result)].offset
    end
  end
end

local function stdProbStyle (prob)
  local color = ""
  if prob >= 0 and prob < 10 then
    color = "black"
  elseif prob >= 10 and prob < 20 then
    color = "pmbTraceRed"
  elseif prob >= 20 and prob < 30 then
    color = "pmbTraceYellow"
  else
    color = "pmbTraceGreen"
  end
  return "ultra thick, " .. color
end

local function findBasesInStr (target)
  if not target then return end
  local result = {}
  for _, v in ipairs(ALL_BASES) do
    if string.find(string.upper(target), v) then
      table.insert(result, v)
    end
  end
  return result
end

function getMinMaxProbability ()
  local minProb = 0
  local maxProb = 0
  for _, currPeak in ipairs(selectedPeaks) do
    for __, currProb in pairs(currPeak.prob) do
      if currProb > maxProb then maxProb = currProb end
      if currProb < minProb then minProb = currProb end
    end
  end
  return minProb, maxProb
end

local function getRange (rangeInput, regExp)
  local lower, upper = string.match(rangeInput, regExp)
  local step = string.match(rangeInput, "step%s*(%d*)")
  return lower, upper, step
end

local function readInt (file, n, offset)
  if offset then file:seek("set", offset) end
  local result = 0
  for i = 1, n do
    result = result * 0x100 + string.byte(file:read(1))
  end
  return result
end

local function evaluateScfFile (file)
  samples = {A = {}, C = {}, G = {}, T = {}}
  peaks = {}
  header = {
    magicNumber = readInt(file, 4, 0),
    samplesNumber = readInt(file, 4),
    samplesOffset = readInt(file, 4),
    basesNumber = readInt(file, 4),
    leftClip = readInt(file, 4),
    rightClip = readInt(file, 4),
    basesOffset = readInt(file, 4),
    comments = readInt(file, 4),
    commentsOffset = readInt(file, 4),
    version = readInt(file, 4),
    sampleSize = readInt(file, 4),
    codeSet = readInt(file, 4),
    privateSize = readInt(file, 4),
    privateOffset = readInt(file, 4)
  }
  if header.magicNumber ~= 0x2E736366 then
    tex.error("Magic number in scf file '" .. lastScfFile .. "' corrupt!")
  end
  if header.version ~= 0x332E3030 then
    tex.error("Scf file '" .. lastScfFile .. "' is not version 3.00!")
  end

  file:seek("set", header.samplesOffset)
  for baseIndex, baseName in ipairs(ALL_BASES) do
    for i = 1, header.samplesNumber do
      samples[baseName][i] = readInt(file, header.sampleSize)
    end

    for _ = 1, 2 do
      local preValue = 0
      for i = 1, header.samplesNumber do
        samples[baseName][i] = samples[baseName][i] + preValue
        if samples[baseName][i] > 0xFFFF then
          samples[baseName][i] = samples[baseName][i] - 0x10000
        end
        preValue = samples[baseName][i]
      end
    end
  end

  for i = 1, header.basesNumber do
    peaks[i] = {
      offset = readInt(file, 4),
      prob = {A, C, G, T},
      base
    }
  end

  for i = 1, header.basesNumber do
    peaks[i].prob.A = readInt(file, 1)
  end

  for i = 1, header.basesNumber do
    peaks[i].prob.C = readInt(file, 1)
  end

  for i = 1, header.basesNumber do
    peaks[i].prob.G = readInt(file, 1)
  end

  for i = 1, header.basesNumber do
    peaks[i].prob.T = readInt(file, 1)
  end

  for i = 1, header.basesNumber do
    peaks[i].base = string.char(readInt(file, 1))
  end
end

function readScfFile (filename)
  if filename ~= lastScfFile then
    lastScfFile = filename
    local scfFile, errorMsg = io.open(filename, "rb")
    if not scfFile then tex.error(errorMsg) end
    evaluateScfFile(scfFile)
    scfFile:close()
  end
end

function setParameters (newParms)
  local sampleRangeMin, sampleRangeMax, sampleRangeStep =
    getRange(
      newParms.sampleRange or "1 to 500 step 1",
      "([base]*%s*%d+)%s*to%s*([base]*%s*%d+)"
    )
  local baseNumberRangeMin, baseNumberRangeMax, baseNumberRangeStep =
    getRange(
      newParms.baseNumberRange or "auto to auto step 10",
      "([auto%d]*)%s+to%s+([auto%d]*)"
    )

  parms = {
    sampleMin = baseToSampleIndex(sampleRangeMin) or 1,
    sampleMax = baseToSampleIndex(sampleRangeMax) or 500,
    sampleStep = sampleRangeStep or 1,
    xUnit = newParms.xUnit or dimen("0.2mm")[1],
    yUnit = newParms.yUnit or dimen("0.01mm")[1],
    samplesPerLine = newParms.samplesPerLine or 500,
    baselineSkip = newParms.baselineSkip or dimen("3cm")[1],
    canvasHeight= newParms.canvasHeight or dimen("2cm")[1],
    traceStyle = {
      A = PGFKEYS_PATH .. "trace A style@style",
      C = PGFKEYS_PATH .. "trace C style@style",
      G = PGFKEYS_PATH .. "trace G style@style",
      T = PGFKEYS_PATH .. "trace T style@style"
    },
    tickStyle = {
      A = PGFKEYS_PATH .. "tick A style@style",
      C = PGFKEYS_PATH .. "tick C style@style",
      G = PGFKEYS_PATH .. "tick G style@style",
      T = PGFKEYS_PATH .. "tick T style@style"
    },
    tickLength = newParms.tickLength or dimen("1mm")[1],
    baseLabelText = {
      A = "\\csname pmb@chr@base label A text\\endcsname",
      C = "\\csname pmb@chr@base label C text\\endcsname",
      G = "\\csname pmb@chr@base label G text\\endcsname",
      T = "\\csname pmb@chr@base label T text\\endcsname"
    },
    baseLabelStyle = {
      A = PGFKEYS_PATH .. "base label A style@style",
      C = PGFKEYS_PATH .. "base label C style@style",
      G = PGFKEYS_PATH .. "base label G style@style",
      T = PGFKEYS_PATH .. "base label T style@style"
    },
    showBaseNumbers = newParms.showBaseNumbers,
    baseNumberMin = tonumber(baseNumberRangeMin) or -1,
    baseNumberMax = tonumber(baseNumberRangeMax) or -1,
    baseNumberStep = tonumber(baseNumberRangeStep) or 10,
    probDistance = newParms.probDistance or dimen("0.8cm")[1],
    probStyle = newParms.probStyle or stdProbStyle,
    tracesDrawn = findBasesInStr(newParms.tracesDrawn) or ALL_BASES,
    ticksDrawn = newParms.ticksDrawn or "ACGT",
    baseLabelsDrawn = newParms.baseLabelsDrawn or "ACGT",
    probabilitiesDrawn = newParms.probabilitiesDrawn or "ACGT",
    coordUnit = "mm",
    coordFmtStr = "%s%s"
  }
end

function printTikzChromatogram ()
  selectedPeaks = {}
  local tIndex = 1
  for rPeakIndex, currPeak in ipairs(peaks) do
    if currPeak.offset >= parms.sampleMin
        and currPeak.offset <= parms.sampleMax then
      selectedPeaks[tIndex] = {
        offset = currPeak.offset + 1 - parms.sampleMin,
        base = currPeak.base,
        prob = currPeak.prob,
        baseIndex = rPeakIndex,
        probXRight = parms.sampleMax + 1 - parms.sampleMin
      }
      if tIndex > 1 then
        selectedPeaks[tIndex-1].probXRight =
          (selectedPeaks[tIndex-1].offset
          + selectedPeaks[tIndex].offset) / 2
      end
      tIndex = tIndex + 1
    end
  end

  if tIndex > 1 then
    if parms.baseNumberMin == -1 then
      parms.baseNumberMin = selectedPeaks[1].baseIndex
    end
    if parms.baseNumberMax == -1 then
      parms.baseNumberMax = selectedPeaks[tIndex-1].baseIndex
    end
  end

  local samplesLeft = parms.sampleMax - parms.sampleMin + 1
  local currLine = 0
  while samplesLeft > 0 do
    local yLower = -currLine * parms.baselineSkip
    local yUpper = -currLine * parms.baselineSkip + parms.canvasHeight
    local xRight =
      (math.min(parms.samplesPerLine, samplesLeft) - 1) * parms.xUnit
    tex.sprint(
      "\\draw[" .. PGFKEYS_PATH .. "canvas style@style] (" ..
      number.todimen(0, parms.coordUnit, parms.coordFmtStr) ..
      ", " ..
      number.todimen(yLower, parms.coordUnit, parms.coordFmtStr) ..
      ") rectangle (" ..
      number.todimen(xRight, parms.coordUnit, parms.coordFmtStr) ..
      ", " ..
      number.todimen(yUpper, parms.coordUnit, parms.coordFmtStr) ..
      ");\n"
    )
    samplesLeft = samplesLeft - parms.samplesPerLine
    currLine = currLine + 1
  end

  for _, baseName in ipairs(parms.tracesDrawn) do
    tex.sprint("\\draw[" .. parms.traceStyle[baseName] .. "] ")
    local currSampleIndex = parms.sampleMin
    local sampleX = 1
    local x = 0
    local y = 0
    local currLine = 0
    local firstPointInLine = true

    while currSampleIndex <= parms.sampleMax do
      x = ((sampleX - 1) % parms.samplesPerLine) * parms.xUnit
      y = samples[baseName][currSampleIndex] * parms.yUnit
        - currLine * parms.baselineSkip
      if sampleX % parms.sampleStep == 0 then
        if not firstPointInLine then
          tex.sprint(" -- ")
        else
          firstPointInLine = false
        end
        tex.sprint(
          "(" ..
          number.todimen(x, parms.coordUnit, parms.coordFmtStr) ..
          ", " ..
          number.todimen(y, parms.coordUnit, parms.coordFmtStr) ..
          ")"
        )
      end
      if sampleX ~= parms.sampleMax + 1 - parms.sampleMin then
        if sampleX >= (currLine + 1) * parms.samplesPerLine then
          currLine = currLine + 1
          tex.sprint(";\n\\draw[" .. parms.traceStyle[baseName] .. "] ")
          firstPointInLine = true
        end
      else
        tex.sprint(";\n")
      end
    sampleX = sampleX + 1
    currSampleIndex = currSampleIndex + 1
    end
  end

  local currLine = 0
  local lastProbX = 1
  local probRemainder = false

  for _, currPeak in ipairs(selectedPeaks) do
    while currPeak.offset > (currLine + 1) * parms.samplesPerLine do
      currLine = currLine + 1
    end

    local x = ((currPeak.offset - 1) % parms.samplesPerLine) * parms.xUnit
    local yUpper = -currLine * parms.baselineSkip
    local yLower = -currLine * parms.baselineSkip - parms.tickLength
    local tickOperation = ""
    if string.find(string.upper(parms.ticksDrawn), currPeak.base) then
      tickOperation = "--"
    end

    tex.sprint(
      "\\draw[" ..
      parms.tickStyle[currPeak.base] ..
      "] (" ..
      number.todimen(x, parms.coordUnit, parms.coordFmtStr) ..
      ", " ..
      number.todimen(yUpper, parms.coordUnit, parms.coordFmtStr) ..
      ") " ..
      tickOperation ..
      " (" ..
      number.todimen(x, parms.coordUnit, parms.coordFmtStr) ..
      ", " ..
      number.todimen(yLower, parms.coordUnit, parms.coordFmtStr) ..
      ")"
    )
    if string.find(string.upper(parms.baseLabelsDrawn), currPeak.base) then
      tex.sprint(
        " node[" ..
        parms.baseLabelStyle[currPeak.base] ..
        "] {" ..
        parms.baseLabelText[currPeak.base] ..
        "}"
      )
    end

    if parms.showBaseNumbers
        and currPeak.baseIndex >= parms.baseNumberMin
        and currPeak.baseIndex <= parms.baseNumberMax
        and (currPeak.baseIndex - parms.baseNumberMin)
          % parms.baseNumberStep == 0 then
      tex.sprint(
        " node[" .. PGFKEYS_PATH .. "base number style@style] {\\strut " ..
        currPeak.baseIndex ..
        "}"
      )
    end
    tex.sprint(";\n")

    if probRemainder then
      tex.sprint(probRemainder)
      probRemainder = false
    end
    local drawCurrProb = string.find(
      string.upper(parms.probabilitiesDrawn),
      currPeak.base
    )
    local xLeft = lastProbX - 1 - currLine * parms.samplesPerLine
    if xLeft < 0 then
      local xLeftPrev = (parms.samplesPerLine + xLeft) * parms.xUnit
      local xRightPrev = (parms.samplesPerLine - 1) * parms.xUnit
      local yPrev = -(currLine-1) * parms.baselineSkip - parms.probDistance
      if drawCurrProb then
        tex.sprint(
          "\\draw[" ..
          parms.probStyle(currPeak.prob[currPeak.base]) ..
          " ] (" ..
          number.todimen(xLeftPrev, parms.coordUnit, parms.coordFmtStr) ..
          ", " ..
          number.todimen(yPrev, parms.coordUnit, parms.coordFmtStr) ..
          ") -- (" ..
          number.todimen(xRightPrev, parms.coordUnit, parms.coordFmtStr) ..
          ", " ..
          number.todimen(yPrev, parms.coordUnit, parms.coordFmtStr) ..
          ");\n"
        )
      end
      xLeft = 0
    else
      xLeft = xLeft * parms.xUnit
    end

    local xRight = currPeak.probXRight - 1 - currLine * parms.samplesPerLine
    if xRight >= parms.samplesPerLine then
      if drawCurrProb then
        local xRightNext = (xRight - parms.samplesPerLine) * parms.xUnit
        local yNext = -(currLine+1) * parms.baselineSkip - parms.probDistance
        probRemainder =
          "\\draw[" ..
          parms.probStyle(currPeak.prob[currPeak.base]) ..
          " ] (" ..
          number.todimen(0, parms.coordUnit, parms.coordFmtStr) ..
          ", " ..
          number.todimen(yNext, parms.coordUnit, parms.coordFmtStr) ..
          ") -- (" ..
          number.todimen(xRightNext, parms.coordUnit, parms.coordFmtStr) ..
          ", " ..
          number.todimen(yNext, parms.coordUnit, parms.coordFmtStr) ..
          ");\n"
      end
      xRight = (parms.samplesPerLine - 1) * parms.xUnit
    else
      xRight = xRight * parms.xUnit
    end

    local y = -currLine * parms.baselineSkip - parms.probDistance
    if drawCurrProb then
      tex.sprint(
        "\\draw[" ..
        parms.probStyle(currPeak.prob[currPeak.base]) ..
        " ] (" ..
        number.todimen(xLeft, parms.coordUnit, parms.coordFmtStr) ..
        ", " ..
        number.todimen(y, parms.coordUnit, parms.coordFmtStr) ..
        ") -- (" ..
        number.todimen(xRight, parms.coordUnit, parms.coordFmtStr) ..
        ", " ..
        number.todimen(y, parms.coordUnit, parms.coordFmtStr) ..
        ");\n"
      )
    end
    lastProbX = currPeak.probXRight
  end
end
--
-- End of file `pgfmolbio.chromatogram.lua'.
