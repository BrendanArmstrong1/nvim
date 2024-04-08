local util = require("plugins.fzf.util")

M = {}

local function path_tail(path)
  for i = #path, 1, -1 do
    if path:sub(i, i) == "/" then
      return path:sub(i + 1, -1)
    end
  end
  return path
end

local function find_tags()
  local tag_files = {}
  local function add_tag_file(lang, file)
    if tag_files[lang] then
      table.insert(tag_files[lang], file)
    else
      tag_files[lang] = { file }
    end
  end

  local help_files = {}
  local all_files = vim.api.nvim_get_runtime_file("doc/*", true)
  for _, fullpath in ipairs(all_files) do
    local file = path_tail(fullpath)
    if file == "tags" then
      add_tag_file("en", fullpath)
    else
      help_files[file] = fullpath
    end
  end

  local tags = {}
  local tags_map = {}
  local delimiter = string.char(9) -- tab
  local tag_corrections = {
    ["%*"] = "\\*",
    ["%("] = "\\(",
    ["%)"] = "\\)",
    ["/"] = "",
  }

  for _, file in ipairs(tag_files["en"]) do
    for line in io.lines(file) do
      if not line:match("^!_TAG_") then
        local fields = vim.split(line, delimiter, { plain = true })
        if #fields == 3 and not tags_map[fields[1]] then
          if fields[1] ~= "help-tags" or fields[2] ~= "tags" then
            local original_tags = fields[3]
            local escaped_tags = fields[3]
            for i, v in pairs(tag_corrections) do
              escaped_tags = string.gsub(escaped_tags, i, v)
            end
            table.insert(
              tags,
              table.concat({
                fields[1],
                help_files[fields[2]],
                escaped_tags,
                original_tags,
              }, "\t")
            )
            tags_map[fields[1]] = true
          end
        end
      end
    end
  end

  return tags
end

local function process_help_tags(line)
  local command = line[1]
  local info = vim.split(line[2], "\t")
  local tag = string.sub(info[4], 3, #info[4] - 2)
  print(vim.inspect(info))
  local cmd
  if command == "enter" then
    cmd = "help "
  elseif command == "ctrl-v" then
    cmd = "vert help "
  end
  vim.cmd(cmd .. tag)
end

function M.fzfiles_command()
	vim.api.nvim_create_user_command("FzFiles", function(args)
		vim.fn["fzf#vim#files"](
			args["args"],
			vim.fn["fzf#vim#with_preview"]({ options = { "--layout=reverse", "--info=inline" } })
		)
	end, { bang = false, nargs = "?", complete = "dir" })
end


function M.fzhelptags_command()
	vim.api.nvim_create_user_command("FzHelpTags", function(_)
		vim.fn["fzf#run"](vim.fn["fzf#wrap"]({
			source = find_tags(),
			sinklist = process_help_tags,
			options = {
				"--layout=reverse",
				"+m",
				"--preview",
				"rg --no-heading -A 20 -B 3 --color=always {3} {2} || echo {3}",
				"--ansi",
				"--tiebreak=begin",
				"--delimiter",
				"\t",
				"--with-nth",
				"1",
				"--expect=ctrl-v,enter",
			},
		}))
	end, { bang = false})
end

function M.setup()
  local binding_cmd = "--bind=ctrl-/:toggle-preview"
	vim.env.FZF_DEFAULT_COMMAND = "rg --files --no-ignore --hidden --follow --glob '!{"
		.. util.ignored_filetypes
		.. "}'"
	vim.env.FZF_DEFAULT_OPTS = "--layout=reverse --info=inline -m " .. binding_cmd
	vim.g.fzf_vim = {
		preview_window = { "right,50%,<70(hidden)", "ctrl-/" },
		buffers_jump = 1,
		commits_log_options = '--graph --color=always --format="%C(auto)%h %an %C(blue)%s %C(yellow)%C(bold)%cr"',
		commands_expect = "enter",
	}
	vim.g.fzf_layout = {
		down = "50%",
	}
	vim.g.fzf_action = {
		["ctrl-t"] = "tab split",
		["ctrl-x"] = "split",
		["ctrl-v"] = "vsplit",
	}
	vim.g.fzf_colors = {
		fg = { "fg", "Normal" },
		bg = { "bg", "Normal" },
		hl = { "fg", "Comment" },
		["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" }, -- current line
		["bg+"] = { "bg", "CursorLine", "CursorColumn" }, -- current line
		["hl+"] = { "fg", "Statement" }, -- current line
		info = { "fg", "PreProc" },
		border = { "fg", "Ignore" },
		prompt = { "fg", "Conditional" },
		pointer = { "fg", "Exception" },
		marker = { "fg", "Keyword" },
		spinner = { "fg", "Label" },
		header = { "fg", "Comment" },
	}
end

return M
