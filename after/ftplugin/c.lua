vim.g.c_syntax_for_h = 1
vim.g.c_gnu = 1
vim.g.c_comment_strings = 1
vim.g.c_no_c11 = 1
vim.g.c_no_c99 = 1
vim.g.c_no_if0 = 1
vim.o.expandtab = true -- expand tabs into spaces on save
vim.o.softtabstop = 2
vim.o.tabstop = 2 -- Number of spaces tabs count for
vim.o.shiftround = true -- Round indent
vim.o.shiftwidth = 2 -- Size of an indent

vim.g.ale_c_clangformat_style_option = [[
{
BasedOnStyle: LLVM,
ColumnLimit: 100,
IndentWidth: 2,

AlignAfterOpenBracket: Align,
AlignConsecutiveMacros: true,
AlignConsecutiveAssignments: true,
AlignConsecutiveDeclarations: true,
AlignEscapedNewlines: Left,
AlignOperands: true,
AlignTrailingComments: true,

AllowAllArgumentsOnNextLine: true,
AllowAllParametersOfDeclarationOnNextLine: true,
AllowShortBlocksOnASingleLine: false,
AllowShortFunctionsOnASingleLine: Empty,
AllowShortIfStatementsOnASingleLine: Never,
AllowShortLoopsOnASingleLine: false,

AlwaysBreakAfterReturnType: None,

BinPackArguments: false,
BinPackParameters: false,

AlwaysBreakBeforeMultilineStrings: true,
ContinuationIndentWidth: 2,

PointerAlignment: Right,
ReflowComments: true,
SpaceAfterCStyleCast: false,
SpaceAfterLogicalNot: false,
SpaceBeforeAssignmentOperators: true,
SpaceBeforeParens: ControlStatementsExceptControlMacros,
SpaceBeforeRangeBasedForLoopColon: true,
SpaceBeforeSquareBrackets: false,
SpaceInEmptyParentheses: false,
SpacesInCStyleCastParentheses: false,
SpacesInParentheses: false,
SpacesInSquareBrackets: false,

BreakBeforeBinaryOperators: NonAssignment,
BreakStringLiterals: true,

BreakBeforeBraces: Custom,
BraceWrapping: {
    AfterClass: true,
    AfterControlStatement: false,
    AfterEnum : true,
    AfterCaseLabel : true,
    AfterFunction : true,
    AfterNamespace : true,
    AfterStruct : true,
    AfterUnion : true,
    BeforeCatch : true,
    BeforeElse : false,
    IndentBraces : false,
    AfterExternBlock : true,
    SplitEmptyFunction : false,
    SplitEmptyRecord : false,
    SplitEmptyNamespace : true,
}
}
]]
