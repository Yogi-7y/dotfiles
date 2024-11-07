local M = {}

function M.is_flutter_project(root_dir)
	if not root_dir then
		return false
	end

	-- Use proper path separator
	local pubspec_path = root_dir .. (root_dir:sub(-1) == "/" and "" or "/") .. "pubspec.yaml"

	-- Debug logging (temporary)
	print("Checking pubspec at: " .. pubspec_path)

	local pubspec_file = io.open(pubspec_path, "r")
	if not pubspec_file then
		print("Could not open pubspec.yaml")
		return false
	end

	local content = pubspec_file:read("*a")
	pubspec_file:close()

	local is_flutter = content:match("dependencies:.-\n[^-]-%s+flutter:") ~= nil
	print("Is Flutter project: " .. tostring(is_flutter))

	return is_flutter
end

return M
