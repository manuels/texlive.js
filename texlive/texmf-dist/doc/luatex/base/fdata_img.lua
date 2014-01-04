-- $Id: fdata_img.lua 4106 2011-04-10 12:51:54Z hhenkel $

local fdata_img = {
  ["functions"] = {
    ["boxes"] = {
      ["arguments"] = {},
      ["returnvalues"] = {
            {
               ["name"] = "boxes",
               ["optional"] = false,
               ["type"] = "table",
            },
      },
      ["shortdesc"] = "Returns a list of supported image bounding box names.",
      ["type"] = "function",
    },
    ["copy"] = {
      ["arguments"] = {
            {
               ["name"] = "var",
               ["optional"] = false,
               ["type"] = "image",
            },
      },
      ["returnvalues"] = {
            {
               ["name"] = "var",
               ["optional"] = false,
               ["type"] = "image",
            },
      },
      ["shortdesc"] = "Copy an image.",
      ["type"] = "function",
    },
    ["immediatewrite"] = {
      ["arguments"] = {
            {
               ["name"] = "var",
               ["optional"] = false,
               ["type"] = "image",
            },
      },
      ["returnvalues"] = {
            {
               ["name"] = "var",
               ["optional"] = false,
               ["type"] = "image",
            },
      },
      ["shortdesc"] = "Write the image to the PDF file immediately.",
      ["type"] = "function",
    },
    ["keys"] = {
      ["arguments"] = {},
      ["returnvalues"] = {
            {
               ["name"] = "keys",
               ["optional"] = false,
               ["type"] = "table",
            },
      },
      ["shortdesc"] = "Returns a table with possible image table keys, including retrieved information.",
      ["type"] = "function",
    },
    ["new"] = {
      ["arguments"] = {
            {
               ["name"] = "var",
               ["optional"] = true,
               ["type"] = "table",
            },
         },
      ["returnvalues"] = {
            {
               ["name"] = "var",
               ["optional"] = false,
               ["type"] = "image",
            },
      },
      ["shortdesc"] = "This function creates an \\quote {image} object.  Allowed fields\
        in the table: \\aliteral{filename} (required), \\aliteral{width},\
        \\aliteral{depth}, \\aliteral{height}, \\aliteral{attr}, \\aliteral{page}, \\aliteral{pagebox}, \\aliteral{colorspace}).",
      ["type"] = "function",
    },
    ["node"] = {
      ["arguments"] = {
         {
            ["name"] = "var",
            ["optional"] = false,
            ["type"] = "image",
         },
      },
      ["returnvalues"] = {
         {
            ["name"] = "n",
            ["optional"] = false,
            ["type"] = "node",
         },
      },
      ["shortdesc"] = "Returns the node associated with an image.",
      ["type"] = "function",
    },
    ["scan"] = {
      ["arguments"] = {
         {
            ["name"] = "var",
            ["optional"] = false,
            ["type"] = "image",
         },
      },
      ["returnvalues"] = {
         {
            ["name"] = "var",
            ["optional"] = false,
            ["type"] = "image",
         },
      },
      ["shortdesc"] = "Processes an image file and stores the retrieved information in the image object.",
      ["type"] = "function",
    },
    ["types"] = {
      ["arguments"] = {},
      ["returnvalues"] = {
         {
            ["name"] = "types",
            ["optional"] = false,
            ["type"] = "table",
         },
      },
      ["shortdesc"] = "Returns a list of supported image types.",
      ["type"] = "function",
    },
    ["write"] = {
      ["arguments"] = {
         {
            ["name"] = "var",
            ["optional"] = false,
            ["type"] = "image",
         },
      },
      ["returnvalues"] = {
         {
            ["name"] = "var",
            ["optional"] = false,
            ["type"] = "image",
         },
      },
      ["shortdesc"] = "Write the image to the PDF file.",
      ["type"] = "function",
    },
  },
  ["methods"] = {
  },
}

return fdata_img
