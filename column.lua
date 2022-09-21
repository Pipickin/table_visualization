require("rows")

Column = {rows = {}, name='', width=25}

function Column:new (c)
	c = c or {}
	setmetatable(c, self)
	self.__index = self
	return c
end

-- addRow("some string")
function Column:addRow (row_string) 
	new_row = Row:new (row_string, self.width)
	table.insert(self.rows, new_row)
end

function Column:getColumn (rows_heights, rows_indexes)
	rows_indexes = rows_indexes or {}
	column_str = {'┏' .. string.rep('━', self.width) .. '┓'}
	column_name_str = '┃' .. self.name .. string.rep(' ', self.width - #self.name) .. '┃'
	table.insert(column_str, column_name_str)
	table.insert(column_str, '┡' .. string.rep('━', self.width) .. '┩')
	if #rows_indexes > 0 then
		for _, i in ipairs(rows_indexes) do
			row = self.rows[i]
			row_str = row:getRow (rows_heights[i])
			for _, row_part in ipairs(row_str) do
				table.insert(column_str, row_part)
			end
		end
	else
		for i, row in ipairs(self.rows) do
			row_str = row:getRow (rows_heights[i])
			for _, row_part in ipairs(row_str) do
				table.insert(column_str, row_part)
--		::continue::
			end
		end
	end
	return column_str
end

	
function Column:getRowsCount ()
	row_counts = {}
	for _, row in ipairs(self.rows) do
		table.insert(row_counts, #row)
	end
	return row_counts
end
		

function Column:drawColumn (rows_heights)
	rows_heights = rows_heights or {}
	print(table.unpack(rows_heights[0][0][0][0][0]))
	local column_str = self:getColumn (rows_heights)
	for _, column_part in ipairs(column_str) do
		print(column_part)
	end
end
	
