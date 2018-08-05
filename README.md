**TL;DR**

`cd min_max_triangle`

`mix escript.build`

`escript min_max_triangle test/test_data`

**How to run**

You need elixir distribution installed. https://repo.hex.pm/elixir-websetup.exe

To compile application:
1) from project root cd to min_max_triangle folder
2) run `mix escript.build`
3) `min_max_triangle` file should appear

To run application:
1) from project root cd to min_max_triangle folder
2) run `escript min_max_triangle <file_path> <optional --max if you want to search for maximal path>`
3) ...
4) PROFIT

To run tests:
1) from project root cd to min_max_triangle folder
2) run `mix test`

**How algorithm works**

1) Iterate through all rows in a triangle
2) After each row we calculate list of elements called `current`, old current is 
discarded on each step
3) `current` is a list of the same size as the current row which contains tuples 
`{sum, path}` where `sum` is a min/max sum to get to the element and `path` 
is a path through the triangle for the corresponding `sum`
4) On each step `current` for the next row is calculated using "current" `current`
and elements from the next row
5) For the first row `current` can be easily created manually as there is no prior 
path/sum
6) On the last row `current` is returned
7) Element with min/max `sum` from the final `current` will contain min/max path through
the whole given triangle