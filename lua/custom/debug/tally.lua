local function get_arguments(service, env)
  local filename = '.tally/' .. service .. '-args-' .. env
  local fn = vim.fn.getenv('HOME') .. '/' .. filename
  local file_content = vim.fn.readfile(fn)
  return vim.split(file_content[1] or '', ' ')
end

return {
  {
    type = "go",
    name = "Debug Tally API Local",
    request = "launch",
    program = "${fileDirname}",
    args = get_arguments('api', 'local'),
  },
  {
    type = "go",
    name = "Debug Tally API Staging",
    request = "launch",
    program = "${fileDirname}",
    args = get_arguments('api', 'staging'),
  },
  {
    type = "go",
    name = "Debug Tally API Prod",
    request = "launch",
    program = "${fileDirname}",
    args = get_arguments('api', 'prod'),
  },
}
