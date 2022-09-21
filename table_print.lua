require('column')


Table = {columns={}, column_width=30, total_rows=0}

function Table:new (t)
	t = t or {}
	setmetatable(t, self)
	self.__index = self
	return t
end

-- addColumn('new_column_name', 10)
function Table:addColumn (column_name, width)
	width = width or self.column_width
	new_column = Column:new {rows={}, name=column_name, width=width}
	table.insert(self.columns, new_column)
end

-- addRows('text in the 1 column', 'text in the 2 column')
function Table:addRows (...)
	string_for_columns = {...}
	for _ = 1,(#string_for_columns - #self.columns) do
		table.insert(string_for_columns, "")
	end
	for index_column, column in ipairs(self.columns) do
		column:addRow (string_for_columns[index_column])
	end
end
	
function Table:drawColumn (column_name)
	for _, column in ipairs(self.columns) do
		if column.name == column_name then
			column:drawColumn ()
		end
	end
end

function Table:getRowsHeights ()
	all_columns_rows_heights = {}
	columns_rows_heights = {}
	for _, column in ipairs(self.columns) do
		column_row_heights = column:getRowsCount ()
		table.insert(all_columns_rows_heights, column_row_heights)
	end
	for row_index=1,#all_columns_rows_heights[1] do
		tmp_heights = {}
		for column_index, _ in ipairs(all_columns_rows_heights) do
			table.insert(tmp_heights, all_columns_rows_heights[column_index][row_index])
		end
		table.insert(columns_rows_heights, math.max(table.unpack(tmp_heights)))
	end
	return columns_rows_heights
end

function Table:concatColumns (columns)
	concat_columns = {}
	for table_part=1,#columns[1] do
		tmp_column_part = {}
		for i, col in ipairs(columns) do
			--[[
			if i == 1 then
				col_part = col[table_part]
			else
				string_from_col = col[table_part]
				print(string_from_col)
				print(type(string_from_col))
				col_part = string_from_col:sub(2,4)
				print(type(col_part))
				--]]
			--end
			col_part = col[table_part]
			table.insert(tmp_column_part, col_part)
		end
	--	print(table.unpack(tmp_column_part))
		table.insert(concat_columns, table.concat(tmp_column_part, ""))
	end
	return concat_columns
end

function Table:getColumnNames ()
	local column_names = {}
	for _, col in ipairs(self.columns) do
		table.insert(column_names, col.name)
	end
	return column_names
end

function Table:printColumnNames ()
	print('Column Names:')
	for _, column_name in ipairs(self:getColumnNames ()) do
		print(column_name)
	end
end

function Table:drawColumns (column_args)
	column_args = column_args or {}	
	row_indexes = column_args['row_indexes'] or {}
	column_names = column_args['column_names'] or self:getColumnNames ()
	rows_heights = self:getRowsHeights () 
	columns_str = {}
	for _, column in ipairs(self.columns) do
		for _, column_name in ipairs(column_names) do
			if column_name == column.name then
				table.insert(columns_str, column:getColumn (rows_heights, row_indexes))
			end
		end
	end
	table_str = self:concatColumns (columns_str)
	for _, table_part in ipairs(table_str) do
		print(table_part)
	end
end
	
function Table:deleteColumns (columns_indexes)
	for _, column_index in ipairs(columns_indexes) do
		table.remove(self.columns, column_index)
	end
end

function Table:deleteRows (rows_indexes)
	for _, row_index in ipairs(rows_indexes) do
		for _, column in ipairs(self.columns) do
			table.remove(column.rows, row_index)
		end
	end
end


