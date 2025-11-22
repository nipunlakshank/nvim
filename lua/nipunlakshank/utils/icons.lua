local M = {}

M.debugging_signs = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
}

M.diagnostic_signs = {
    ERROR = " ",
    WARN = " ",
    HINT = "",
    INFO = "",
}

M.cmp_icons = {
    BladeNav = "",
    Emmet = "",
}

return M
