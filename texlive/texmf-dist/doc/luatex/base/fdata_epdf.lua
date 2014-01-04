-- $Id: fdata_epdf.lua 4559 2013-01-20 19:58:26Z hhenkel $

local fdata_epdf = {
  functions = {
    open = {
      type = "function",
      shortdesc = "Construct a PDFDoc object by opening a PDF document.",
      arguments = {
        {type = "string", name = "filename", optional = false, },
      },
      returnvalues = {
        {type = "PDFDoc", name = "var", optional = false, },
      },
    },
    Annot = {
      type = "function",
      shortdesc = "Construct an Annot object.",
      arguments = {
        {type = "XRef", name = "xref", optional = false, },
        {type = "Dict", name = "dict", optional = false, },
        {type = "Catalog", name = "catalog", optional = false, },
        {type = "Ref", name = "ref", optional = false, },
      },
      returnvalues = {
        {type = "Annot", name = "var", optional = false, },
      },
    },
    Annots = {
      type = "function",
      shortdesc = "Construct an Annots object.",
      arguments = {
        {type = "XRef", name = "xref", optional = false, },
        {type = "Catalog", name = "catalog", optional = false, },
        {type = "Object", name = "object", optional = false, },
      },
      returnvalues = {
        {type = "Annots", name = "var", optional = false, },
      },
    },
    Array = {
      type = "function",
      shortdesc = "Construct an Array object.",
      arguments = {
        {type = "XRef", name = "xref", optional = false, },
      },
      returnvalues = {
        {type = "Array", name = "var", optional = false, },
      },
    },
    Dict = {
      type = "function",
      shortdesc = "Construct a Dict object.",
      arguments = {
        {type = "XRef", name = "xref", optional = false, },
      },
      returnvalues = {
        {type = "Dict", name = "var", optional = false, },
      },
    },
    Object = {
      type = "function",
      shortdesc = "Construct an Object object.",
      arguments = {
      },
      returnvalues = {
        {type = "Object", name = "var", optional = false, },
      },
    },
    PDFRectangle = {
      type = "function",
      shortdesc = "Construct a PDFRectangle object.",
      arguments = {
      },
      returnvalues = {
        {type = "PDFRectangle", name = "var", optional = false, },
      },
    },
  },
  methods = {
------------------------------------------------------------------------
    Annot = {
      isOK = {
        type = "function",
        shortdesc = "Check if Annot object is ok.",
        arguments = {
          {type = "Annot", name = "annot", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getAppearance = {
        type = "function",
        shortdesc = "Get Appearance object.",
        arguments = {
          {type = "Annot", name = "annot", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      getBorder = {
        type = "function",
        shortdesc = "Get AnnotBorder object.",
        arguments = {
          {type = "Annot", name = "annot", optional = false, },
        },
        returnvalues = {
          {type = "AnnotBorder", name = "var", optional = false, },
        },
      },
      match = {
        type = "function",
        shortdesc = "Check if object number and generation matches Ref.",
        arguments = {
          {type = "Annot", name = "annot", optional = false, },
          {type = "Ref", name = "ref", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    AnnotBorderStyle = {
      getWidth = {
        type = "function",
        shortdesc = "Get border width.",
        arguments = {
          {type = "AnnotBorderStyle", name = "annotborderstyle", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    Annots = {
      getNumAnnots = {
        type = "function",
        shortdesc = "Get number of Annots objects.",
        arguments = {
          {type = "Annots", name = "annots", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getAnnot = {
        type = "function",
        shortdesc = "Get Annot object.",
        arguments = {
          {type = "Annots", name = "annots", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "Annot", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    Array = {
      incRef = {
        type = "function",
        shortdesc = "Increment reference count to Array.",
        arguments = {
          {type = "Array", name = "array", optional = false, },
        },
        returnvalues = {
        },
      },
      decRef = {
        type = "function",
        shortdesc = "Decrement reference count to Array.",
        arguments = {
          {type = "Array", name = "array", optional = false, },
        },
        returnvalues = {
        },
      },
      getLength = {
        type = "function",
        shortdesc = "Get Array length.",
        arguments = {
          {type = "Array", name = "array", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      add = {
        type = "function",
        shortdesc = "Add Object to Array.",
        arguments = {
          {type = "Array", name = "array", optional = false, },
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
        },
      },
      get = {
        type = "function",
        shortdesc = "Get Object from Array.",
        arguments = {
          {type = "Array", name = "array", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      getNF = {
        type = "function",
        shortdesc = "Get Object from Array, not resolving indirection.",
        arguments = {
          {type = "Array", name = "array", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      getString = {
        type = "function",
        shortdesc = "Get String from Array.",
        arguments = {
          {type = "Array", name = "array", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    Catalog = {
      isOK = {
        type = "function",
        shortdesc = "Check if Catalog object is ok.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getNumPages = {
        type = "function",
        shortdesc = "Get total number of pages.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getPage = {
        type = "function",
        shortdesc = "Get Page.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "Page", name = "var", optional = false, },
        },
      },
      getPageRef = {
        type = "function",
        shortdesc = "Get the reference to a Page object.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "Ref", name = "var", optional = false, },
        },
      },
      getBaseURI = {
        type = "function",
        shortdesc = "Get base URI, if any.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      readMetadata = {
        type = "function",
        shortdesc = "Get the contents of the Metadata stream.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      getStructTreeRoot = {
        type = "function",
        shortdesc = "Get the structure tree root object.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      findPage = {
        type = "function",
        shortdesc = "Get a Page number by object number and generation.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
          {type = "integer", name = "object number", optional = false, },
          {type = "integer", name = "object generation", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      findDest = {
        type = "function",
        shortdesc = "Find a named destination.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
          {type = "string", name = "string", optional = false, },
        },
        returnvalues = {
          {type = "LinkDest", name = "var", optional = false, },
        },
      },
      getDests = {
        type = "function",
        shortdesc = "Get destinations object.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      numEmbeddedFiles = {
        type = "function",
        shortdesc = "Get number of embedded files.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      embeddedFile = {
        type = "function",
        shortdesc = "Get file spec of embedded file.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "FileSpec", name = "var", optional = false, },
        },
      },
      numJS = {
        type = "function",
        shortdesc = "Get number of javascript scripts.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getJS = {
        type = "function",
        shortdesc = "Get javascript script.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      getOutline = {
        type = "function",
        shortdesc = "Get Outline object.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      getAcroForm = {
        type = "function",
        shortdesc = "Get AcroForm object.",
        arguments = {
          {type = "Catalog", name = "catalog", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    EmbFile = {
      name = {
        type = "function",
        shortdesc = "Get name of embedded file.",
        arguments = {
          {type = "EmbFile", name = "embfile", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      description = {
        type = "function",
        shortdesc = "Get description of embedded file.",
        arguments = {
          {type = "EmbFile", name = "embfile", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      size = {
        type = "function",
        shortdesc = "Get size of embedded file.",
        arguments = {
          {type = "EmbFile", name = "embfile", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      modDate = {
        type = "function",
        shortdesc = "Get modification date of embedded file.",
        arguments = {
          {type = "EmbFile", name = "embfile", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      createDate = {
        type = "function",
        shortdesc = "Get creation date of embedded file.",
        arguments = {
          {type = "EmbFile", name = "embfile", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      checksum = {
        type = "function",
        shortdesc = "Get checksum of embedded file.",
        arguments = {
          {type = "EmbFile", name = "embfile", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      mimeType = {
        type = "function",
        shortdesc = "Get mime type of embedded file.",
        arguments = {
          {type = "EmbFile", name = "embfile", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      streamObject = {
        type = "function",
        shortdesc = "Get stream object of embedded file.",
        arguments = {
          {type = "EmbFile", name = "embfile", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      isOk = {
        type = "function",
        shortdesc = "Check if embedded file is ok.",
        arguments = {
          {type = "EmbFile", name = "embfile", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      save = {
        type = "function",
        shortdesc = "Save embedded file to disk.",
        arguments = {
          {type = "EmbFile", name = "embfile", optional = false, },
          {type = "string", name = "var", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    FileSpec = {
      isOk = {
        type = "function",
        shortdesc = "Check if filespec is ok.",
        arguments = {
          {type = "FileSpec", name = "filespec", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getFileName = {
        type = "function",
        shortdesc = "Get file name of filespec.",
        arguments = {
          {type = "FileSpec", name = "filespec", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "string", optional = false, },
        },
      },
      getFileNameForPlatform = {
        type = "function",
        shortdesc = "Get file name for platform of filespec.",
        arguments = {
          {type = "FileSpec", name = "filespec", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "string", optional = false, },
        },
      },
      getDescription = {
        type = "function",
        shortdesc = "Get description of filespec.",
        arguments = {
          {type = "FileSpec", name = "filespec", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "string", optional = false, },
        },
      },
      getEmbeddedFile = {
        type = "function",
        shortdesc = "Get embedded file of filespec.",
        arguments = {
          {type = "FileSpec", name = "filespec", optional = false, },
        },
        returnvalues = {
          {type = "EmbFile", name = "embfile", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    Dict = {
      incRef = {
        type = "function",
        shortdesc = "Increment reference count to Dict.",
        arguments = {
          {type = "Dict", name = "dict", optional = false, },
        },
        returnvalues = {
        },
      },
      decRef = {
        type = "function",
        shortdesc = "Decrement reference count to Dict.",
        arguments = {
          {type = "Dict", name = "dict", optional = false, },
        },
        returnvalues = {
        },
      },
      getLength = {
        type = "function",
        shortdesc = "Get Dict length.",
        arguments = {
          {type = "Dict", name = "dict", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      add = {
        type = "function",
        shortdesc = "Add Object to Dict.",
        arguments = {
          {type = "Dict", name = "dict", optional = false, },
          {type = "string", name = "string", optional = false, },
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
        },
      },
      set = {
        type = "function",
        shortdesc = "Set Object in Dict.",
        arguments = {
          {type = "Dict", name = "dict", optional = false, },
          {type = "string", name = "string", optional = false, },
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
        },
      },
      remove = {
        type = "function",
        shortdesc = "Remove entry from Dict.",
        arguments = {
          {type = "Dict", name = "dict", optional = false, },
          {type = "string", name = "string", optional = false, },
        },
        returnvalues = {
        },
      },
      is = {
        type = "function",
        shortdesc = "Check if Dict is of given /Type.",
        arguments = {
          {type = "Dict", name = "dict", optional = false, },
          {type = "string", name = "string", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      lookup = {
        type = "function",
        shortdesc = "Look up Dict entry.",
        arguments = {
          {type = "Dict", name = "dict", optional = false, },
          {type = "string", name = "string", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      lookupNF = {
        type = "function",
        shortdesc = "Look up Dict entry, not resolving indirection.",
        arguments = {
          {type = "Dict", name = "dict", optional = false, },
          {type = "string", name = "string", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      lookupInt = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Dict", name = "dict", optional = false, },
          {type = "string", name = "string", optional = false, },
          {type = "string", name = "string", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getKey = {
        type = "function",
        shortdesc = "Get key from Dict by number.",
        arguments = {
          {type = "Dict", name = "dict", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      getVal = {
        type = "function",
        shortdesc = "Get value from Dict by number.",
        arguments = {
          {type = "Dict", name = "dict", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      getValNF = {
        type = "function",
        shortdesc = "Get value from Dict by number, not resolving indirection.",
        arguments = {
          {type = "Dict", name = "dict", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      hasKey = {
        type = "function",
        shortdesc = "Check if Dict contains /Key.",
        arguments = {
          {type = "Dict", name = "dict", optional = false, },
          {type = "string", name = "string", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    Link = {
      isOK = {
        type = "function",
        shortdesc = "Check if Link object is ok.",
        arguments = {
          {type = "Link", name = "link", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      inRect = {
        type = "function",
        shortdesc = "Check if point is inside the link rectangle.",
        arguments = {
          {type = "Link", name = "link", optional = false, },
          {type = "number", name = "number", optional = false, },
          {type = "number", name = "number", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    LinkDest = {
      isOK = {
        type = "function",
        shortdesc = "Check if LinkDest object is ok.",
        arguments = {
          {type = "LinkDest", name = "linkdest", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getKind = {
        type = "function",
        shortdesc = "Get number of LinkDest kind.",
        arguments = {
          {type = "LinkDest", name = "linkdest", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getKindName = {
        type = "function",
        shortdesc = "Get name of LinkDest kind.",
        arguments = {
          {type = "LinkDest", name = "linkdest", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      isPageRef = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "LinkDest", name = "linkdest", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getPageNum = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "LinkDest", name = "linkdest", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getPageRef = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "LinkDest", name = "linkdest", optional = false, },
        },
        returnvalues = {
          {type = "Ref", name = "var", optional = false, },
        },
      },
      getLeft = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "LinkDest", name = "linkdest", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getBottom = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "LinkDest", name = "linkdest", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getRight = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "LinkDest", name = "linkdest", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getTop = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "LinkDest", name = "linkdest", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getZoom = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "LinkDest", name = "linkdest", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getChangeLeft = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "LinkDest", name = "linkdest", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getChangeTop = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "LinkDest", name = "linkdest", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getChangeZoom = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "LinkDest", name = "linkdest", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    Links = {
      getNumLinks = {
        type = "function",
        shortdesc = "Get number of links.",
        arguments = {
          {type = "Links", name = "links", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getLink = {
        type = "function",
        shortdesc = "Get link by number.",
        arguments = {
          {type = "Links", name = "links", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "Link", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    Object = {
      initBool = {
        type = "function",
        shortdesc = "Initialize a Bool-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "boolean", name = "boolean", optional = false, },
        },
        returnvalues = {
        },
      },
      initInt = {
        type = "function",
        shortdesc = "Initialize an Int-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
        },
      },
      initReal = {
        type = "function",
        shortdesc = "Initialize a Real-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "number", name = "number", optional = false, },
        },
        returnvalues = {
        },
      },
      initString = {
        type = "function",
        shortdesc = "Initialize a String-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "string", name = "string", optional = false, },
        },
        returnvalues = {
        },
      },
      initName = {
        type = "function",
        shortdesc = "Initialize a Name-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "string", name = "string", optional = false, },
        },
        returnvalues = {
        },
      },
      initNull = {
        type = "function",
        shortdesc = "Initialize a Null-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
        },
      },
      initArray = {
        type = "function",
        shortdesc = "Initialize an Array-type object with an empty array.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
        },
      },
      initDict = {
        type = "function",
        shortdesc = "Initialize a Dict-type object with an empty dictionary.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
        },
      },
      initStream = {
        type = "function",
        shortdesc = "Initialize a Stream-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "Stream", name = "stream", optional = false, },
        },
        returnvalues = {
        },
      },
      initRef = {
        type = "function",
        shortdesc = "Initialize a Ref-type object by object number and generation.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "integer", name = "object number", optional = false, },
          {type = "integer", name = "object generation", optional = false, },
        },
        returnvalues = {
        },
      },
      initCmd = {
        type = "function",
        shortdesc = "Initialize a Cmd-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "string", name = "string", optional = false, },
        },
        returnvalues = {
        },
      },
      initError = {
        type = "function",
        shortdesc = "Initialize an Error-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
        },
      },
      initEOF = {
        type = "function",
        shortdesc = "Initialize an EOF-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
        },
      },
      fetch = {
        type = "function",
        shortdesc = "If object is of type Ref, fetch and return the referenced object. Otherwise, return a copy of the object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      getType = {
        type = "function",
        shortdesc = "Get object type as a number (enum ObjType).",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getTypeName = {
        type = "function",
        shortdesc = "Get object type name.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      isBool = {
        type = "function",
        shortdesc = "Check if object is of type Bool.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isInt = {
        type = "function",
        shortdesc = "Check if object is of type Int.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isReal = {
        type = "function",
        shortdesc = "Check if object is of type Real.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isNum = {
        type = "function",
        shortdesc = "Check if object is of type Num.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isString = {
        type = "function",
        shortdesc = "Check if object is of type String.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isName = {
        type = "function",
        shortdesc = "Check if object is of type Name.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isNull = {
        type = "function",
        shortdesc = "Check if object is of type Null.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isArray = {
        type = "function",
        shortdesc = "Check if object is of type Array.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isDict = {
        type = "function",
        shortdesc = "Check if object is of type Dict.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isStream = {
        type = "function",
        shortdesc = "Check if object is of type Stream.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isRef = {
        type = "function",
        shortdesc = "Check if object is of type Ref.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isCmd = {
        type = "function",
        shortdesc = "Check if object is of type Cmd.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isError = {
        type = "function",
        shortdesc = "Check if object is of type Error.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isEOF = {
        type = "function",
        shortdesc = "Check if object is of type EOF.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isNone = {
        type = "function",
        shortdesc = "Check if object is of type None.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getBool = {
        type = "function",
        shortdesc = "Get boolean from Bool-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getInt = {
        type = "function",
        shortdesc = "Get integer from Int-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getReal = {
        type = "function",
        shortdesc = "Get number from Real-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getNum = {
        type = "function",
        shortdesc = "Get number from Num-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getString = {
        type = "function",
        shortdesc = "Get string from String-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      getName = {
        type = "function",
        shortdesc = "Get name from Name-type object as a string.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      getArray = {
        type = "function",
        shortdesc = "Get Array from Array-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "Array", name = "var", optional = false, },
        },
      },
      getDict = {
        type = "function",
        shortdesc = "Get Dict from Dict-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "Dict", name = "var", optional = false, },
        },
      },
      getStream = {
        type = "function",
        shortdesc = "Get Stream from Stream-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "Stream", name = "var", optional = false, },
        },
      },
      getRef = {
        type = "function",
        shortdesc = "Get Ref from Ref-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "Ref", name = "var", optional = false, },
        },
      },
      getRefNum = {
        type = "function",
        shortdesc = "Get object number from Ref-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getRefGen = {
        type = "function",
        shortdesc = "Get object generation from Ref-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getCmd = {
        shortdesc = "Get command from Cmd-type object as a string.",
        shortdesc = "TODO",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      arrayGetLength = {
        type = "function",
        shortdesc = "Get array length from Array-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      arrayAdd = {
        type = "function",
        shortdesc = "Add Object to Array-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
        },
      },
      arrayGet = {
        type = "function",
        shortdesc = "Get Object from Array-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      arrayGetNF = {
        type = "function",
        shortdesc = "Get Object from Array-type object, not resolving indirection.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      dictGetLength = {
        type = "function",
        shortdesc = "Get dictionary length from Dict-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      dictAdd = {
        type = "function",
        shortdesc = "Add Object to Dict-type object.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "string", name = "string", optional = false, },
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
        },
      },
      dictSet = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "string", name = "string", optional = false, },
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
        },
      },
      dictLookup = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "string", name = "string", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      dictLookupNF = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "string", name = "string", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      dictGetKey = {
        type = "function",
        shortdesc = "Get Dict key of Dict-type object by number.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      dictGetVal = {
        type = "function",
        shortdesc = "Get Dict value of Dict-type object by number.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      dictGetValNF = {
        type = "function",
        shortdesc = "Get Dict value of Dict-type object by number, not resolving indirection.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      streamIs = {
        type = "function",
        shortdesc = "Check if object contains a stream whose dictionary is of given /Type.",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "string", name = "string", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      streamReset = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
        },
      },
      streamGetChar = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      streamLookChar = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      streamGetPos = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      streamSetPos = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Object", name = "object", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
        },
      },
      streamGetDict = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Object", name = "object", optional = false, },
        },
        returnvalues = {
          {type = "Dict", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    Page = {
      isOK = {
        type = "function",
        shortdesc = "Check if Page object is ok.",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getNum = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getMediaBox = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "PDFRectangle", name = "var", optional = false, },
        },
      },
      getCropBox = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "PDFRectangle", name = "var", optional = false, },
        },
      },
      isCropped = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getMediaWidth = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getMediaHeight = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getCropWidth = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getCropHeight = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getBleedBox = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "PDFRectangle", name = "var", optional = false, },
        },
      },
      getTrimBox = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "PDFRectangle", name = "var", optional = false, },
        },
      },
      getArtBox = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "PDFRectangle", name = "var", optional = false, },
        },
      },
      getRotate = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getLastModified = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      getBoxColorInfo = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "Dict", name = "var", optional = false, },
        },
      },
      getGroup = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "Dict", name = "var", optional = false, },
        },
      },
      getMetadata = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "Stream", name = "var", optional = false, },
        },
      },
      getPieceInfo = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "Dict", name = "var", optional = false, },
        },
      },
      getSeparationInfo = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "Dict", name = "var", optional = false, },
        },
      },
      getResourceDict = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "Dict", name = "var", optional = false, },
        },
      },
      getAnnots = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      getLinks = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
          {type = "Catalog", name = "catalog", optional = false, },
        },
        returnvalues = {
          {type = "Links", name = "var", optional = false, },
        },
      },
      getContents = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Page", name = "page", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    PDFDoc = {
      isOK = {
        type = "function",
        shortdesc = "Check if PDFDoc object is ok.",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getErrorCode = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getErrorCodeName = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      getFileName = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      getXRef = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "XRef", name = "var", optional = false, },
        },
      },
      getCatalog = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "Catalog", name = "var", optional = false, },
        },
      },
      getPageMediaWidth = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getPageMediaHeight = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getPageCropWidth = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getPageCropHeight = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "number", name = "var", optional = false, },
        },
      },
      getNumPages = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      readMetadata = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      getStructTreeRoot = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      findPage = {
        type = "function",
        shortdesc = "Get a Page number by object number and generation.",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
          {type = "integer", name = "object number", optional = false, },
          {type = "integer", name = "object generation", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getLinks = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "Links", name = "var", optional = false, },
        },
      },
      findDest = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
          {type = "string", name = "string", optional = false, },
        },
        returnvalues = {
          {type = "LinkDest", name = "var", optional = false, },
        },
      },
      isEncrypted = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      okToPrint = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      okToChange = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      okToCopy = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      okToAddNotes = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      isLinearized = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getDocInfo = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      getDocInfoNF = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      getPDFMajorVersion = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getPDFMinorVersion = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFDoc", name = "pdfdoc", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    PDFRectangle = {
      isValid = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "PDFRectangle", name = "pdfrectangle", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    Stream = {
      getKind = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Stream", name = "stream", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getKindName = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Stream", name = "stream", optional = false, },
        },
        returnvalues = {
          {type = "string", name = "var", optional = false, },
        },
      },
      reset = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Stream", name = "stream", optional = false, },
        },
        returnvalues = {
        },
      },
      close = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Stream", name = "stream", optional = false, },
        },
        returnvalues = {
        },
      },
      getChar = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Stream", name = "stream", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      lookChar = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Stream", name = "stream", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getRawChar = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Stream", name = "stream", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getUnfilteredChar = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Stream", name = "stream", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      unfilteredReset = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Stream", name = "stream", optional = false, },
        },
        returnvalues = {
        },
      },
      getPos = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Stream", name = "stream", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      isBinary = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Stream", name = "stream", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getUndecodedStream = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Stream", name = "stream", optional = false, },
        },
        returnvalues = {
          {type = "Stream", name = "var", optional = false, },
        },
      },
      getDict = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "Stream", name = "stream", optional = false, },
        },
        returnvalues = {
          {type = "Dict", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
    XRef = {
      isOK = {
        type = "function",
        shortdesc = "Check if XRef object is ok.",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getErrorCode = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      isEncrypted = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      okToPrint = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      okToPrintHighRes = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      okToChange = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      okToCopy = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      okToAddNotes = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      okToFillForm = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      okToAccessibility = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      okToAssemble = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "boolean", name = "var", optional = false, },
        },
      },
      getCatalog = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      fetch = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
          {type = "integer", name = "integer", optional = false, },
          {type = "integer", name = "integer", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      getDocInfo = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      getDocInfoNF = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
      getNumObjects = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getRootNum = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getRootGen = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getSize = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "integer", name = "var", optional = false, },
        },
      },
      getTrailerDict = {
        type = "function",
        shortdesc = "TODO",
        arguments = {
          {type = "XRef", name = "xref", optional = false, },
        },
        returnvalues = {
          {type = "Object", name = "var", optional = false, },
        },
      },
    },
------------------------------------------------------------------------
  }
}

return fdata_epdf
