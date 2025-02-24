--- Markdown native support for SILE
--
-- @copyright License: MIT (c) 2022 Omikhleia
-- @module packages.markdown
--
local base = require("packages.base")

local package = pl.class(base)
package._name = "markdown"

--- Package initialization.
--
-- It basically loads the required common packages,
-- and loads the markdown inputter.
function package:_init ()
  base._init(self)
  self.class:loadPackage("markdown.commands")

  -- Extend inputters if needed.
  -- Chicken and eggs... This just forces the inputter to be loaded!
  local _ = SILE.inputters.markdown
end

--- Package raw handler registrations.
--
-- It enables a raw handler for markdown content.
function package:registerRawHandlers ()

  self.class:registerRawHandler("markdown", function(options, content)
    SILE.processString(content[1], "markdown", nil, options)
  end)

end

package.documentation = [[\begin{document}
The \autodoc:package{markdown} package allows you to use Markdown, with plenty of additional
features and extensions, as your alternative format of choice for documents—without leaving
aside hooks to SILE, when felt necessary\footnote{So you get the best of two worlds, for an
efficient and direct Markdown to PDF conversion.}.

Once you have loaded the package, the \autodoc:command{\include[src=<file>]} command supports
natively reading and processing a Markdown file:

\begin{verbatim}
\\use[module=packages.markdown]
\\include[src=somefile.md]
\end{verbatim}

\smallskip

Other possibilities exist (such as setting \autodoc:parameter{format=markdown} on the
\autodoc:command{\include} command, if the file extension cannot be one of the supported variants, etc.).
Refer to the SILE manual for more details on inputters and their usage.

Embedding raw Markdown content from within a SILE document is also possible:

\begin{verbatim}
\\begin[type=markdown]\{raw\}
Some **Markdown** content
\\end\{raw\}
\end{verbatim}

\smallskip

The speedy Markdown parsing relies on John MacFarlane’s excellent \strong{lunamark} Lua library,
which empovers this package and thus allows native processing of Markdown directly within SILE,
as a first-class language.
\end{document}]]

return package
