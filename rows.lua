local function splitByChunk(text, chunkSize)
	local s = {}
	for i=1, #text, chunkSize do
		s[#s+1] = text:sub(i,i+chunkSize - 1)
	end
	return s
end


Row = {}

-- stringPreproc('long sentence')
-- output {'long sen', 'tence'}
function Row:stringPreproc (row_string, row_length)
	local strings = splitByChunk(row_string, row_length)
	last_string = strings[#strings]
	last_string = last_string .. string.rep(' ', row_length - #last_string)
	strings[#strings] = last_string
	return strings
end

-- input r = "12345678"
-- output r = {"123", "456", "78"}
function Row:new (row_string, row_length)
	local	row_strings = self:stringPreproc (row_string, row_length)
	setmetatable(row_strings, self)
	self.__index = self
	return row_strings
end

function Row:getRow (inner_row_height)
	row_size = #self[1]
	inner_row_height = inner_row_height or #self
	row_str = {}
	for _, row in ipairs(self) do
		inner_row = '│' .. row .. '│'
		table.insert(row_str, inner_row)
	end
	for _ = 1,(inner_row_height - #self) do 
		empty_row = '|' .. string.rep(' ', row_size) .. '|'	
		table.insert(row_str, empty_row)
	end
	table.insert(row_str, '+' .. string.rep('─', row_size) .. '+')
	return row_str
end
