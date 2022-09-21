require('table_print')


t = Table:new {}

t:addColumn ('First column', 15)
t:addColumn ('Second column', 20)
t:addColumn ('Third column')

t:addRows ('Hell On Earth', 'Hollywood Undead', 'the third column')
t:addRows ('Some text', '789bbbbbb', 'dArchitects are a British metalcore band from Brighton, East Sussex')
t:addRows ('Royal Beggars', 'Hollywood Undead', 'Asking Alexandria')
t:addRows ('NO TURNING BACK', 'NEFFEX', 'Architects')
t:addRows ('2222fiewfj', '22222bbbb', 'okmko')

-- Print columns' names
t:printColumnNames ()

-- Draw full column
t:drawColumns ()

-- Draw all column with special rows
t:drawColumns ({row_indexes={1, 2}})

-- Draw special columns and special rows
t:drawColumns ({column_names={'First column', 'Third column'}, row_indexes={1, 2, 4}})

-- Delete special rows
t:deleteRows({1, 3, 4})
t:drawColumns ()

-- Delete column by index
t:deleteColumns ({1})
t:drawColumns ()

