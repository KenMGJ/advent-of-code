puzzle_input <- read.delim("~/advent-of-code/2017/02/input.txt", header = FALSE, sep = "\t")
puzzle_input$min <- apply(puzzle_input, 1, min, na.rm = TRUE)
puzzle_input$max <- apply(puzzle_input, 1, max, na.rm = TRUE)
puzzle_input$diff <- puzzle_input$max - puzzle_input$min
print(sum(puzzle_input$diff))

row_index <- 1
row_count <- nrow(puzzle_input)

min_mod <- numeric(length = row_count)
max_mod <- numeric(length = row_count)

while (row_index <= row_count) {
  found <- FALSE
  sorted_values <- sort(as.numeric(as.vector(puzzle_input[row_index,1:16])), decreasing = TRUE)
  
  col_index <- 1
  while (col_index < 16) {
    col_cpm_index <- col_index + 1
    while (col_cpm_index <= 16) {
      if (sorted_values[col_index] %% sorted_values[col_cpm_index] == 0) {
        min_mod[row_index] <- sorted_values[col_cpm_index]
        max_mod[row_index] <- sorted_values[col_index]
        found <- TRUE
        break;
      }
      col_cpm_index <- col_cpm_index + 1
    }

    if (found) {
      break;
    }      
    col_index <- col_index + 1
  }
  row_index <- row_index + 1
}

puzzle_input$minMod = min_mod
puzzle_input$maxMod = max_mod
puzzle_input$diffMod <- puzzle_input$maxMod / puzzle_input$minMod
print(sum(puzzle_input$diffMod))