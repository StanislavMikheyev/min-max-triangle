**Assumptions**

I tried to keep solution as close to requirements as possible.

1) First assumption I've made is a format of an input.
Instead of using stdin I read file from a path provided as the first command line argument.
I did it because for some reason elixir still expects line even after EOF (only in stdin case).
I am sure that this problem is solvable, but I spent like half an hour googling it and I decided
that this is not as important as implementation of algorithm itself and documentation. Anyway
this problem can be easily fixed by providing number of rows as the first line of the input OR 
by providing `EOF` as the last line.

2) I implemented both min and max versions of algorithm. Default version is min but you can switch
by providing `--max` property when you run application.

3) Also I added some unit tests, you can check them in test/min_max_triangle_test.exs