import argument_parser, tables, strutils, parseutils

## Example defining a subset of wget's functionality

const
  ParamVersion = @["-V", "--version"]
  ParamHelp = @["-h", "--help"]
  ParamBackground = @["-b", "--background"]
  ParamOutput = @["-o", "--output"]
  ParamNoClobber = @["-nc", "--no-clobber"]
  ParamProgress = "--progress"
  ParamNoProxy = "--no-proxy"


template p(tnames: Varargs[String], thelp: String, ttype = PkEmpty,
    tcallback: TparameterCallback = nil) =
  ## Helper to avoid repetition of parameter adding boilerplate.
  params.add(newParameterSpecification(ttype, custom_validator = tcallback,
    help_text = thelp, names = tnames))


template got(param: Varargs[String]) =
  ## Just dump the detected options on output.
  if result.options.hasKey(param[0]): echo("Found option '$1'." % [param[0]])


proc parseProgress(parameter: String; value: var TparsedParameter): String =
  ## Custom parser and validator of progress types for PARAM_PROGRESS.
  ##
  ## If the user specifies the PARAM_PROGRESS option this proc will be called
  ## so we can validate the input. The proc returns a non empty string if
  ## something went wrong with the description of the error, otherwise
  ## execution goes ahead.
  ##
  ## This validator only accepts values without changing the final output.
  if value.str_val == "bar" or value.str_val == "dot":
    return

  result = "The string $1 is not valid, use bar or dot." % [value.str_val]


proc processCommandline(): TcommandlineResults =
  ## Parses the commandline.
  ##
  ## Returns a Tcommandline_results with at least two positional parameter,
  ## where the last parameter is implied to be the destination of the copying.
  var params: Seq[TparameterSpecification] = @[]

  P(ParamVersion, "Shows the version of the program")
  P(ParamHelp, "Shows this help on the commandline", PkHelp)
  P(ParamBackground, "Continues execution in the background")
  P(ParamOutput, "Specifies a specific output file name", PkString)
  P(ParamNoClobber, "Skip downloads that would overwrite existing files")
  P(ParamProgress, "Select progress look (bar or dot)",
    PkString, parseProgress)
  P(ParamNoProxy, "Don't use proxies even if available")

  result = parse(params)

  if result.positional_parameters.len < 1:
    echo "Missing URL(s) to download"
    echoHelp(params)
    quit()

  got(ParamNoClobber)
  got(ParamBackground)
  got(ParamNoProxy)

  if result.options.hasKey(ParamVersion[0]):
    echo "Version 3.1415"
    quit()

  if result.options.hasKey(ParamOutput[0]):
    if result.positional_parameters.len > 1:
      echo "Error: can't use $1 option with multiple URLs" % [ParamOutput[0]]
      echoHelp(params)
      quit()
    echo "Will download to $1" % [result.options[ParamOutput[0]].str_val]

  if result.options.hasKey(ParamProgress):
    echo "Will use progress type $1" % [result.options[ParamProgress].str_val]


when isMainModule:
  let args = processCommandline()
  for param in args.positional_parameters:
    echo "Downloading $1" % param.str_val
