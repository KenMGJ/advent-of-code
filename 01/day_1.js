directions = $('pre').innerText; floor_number = 0; for (i = 0; i < directions.length; i++) { if (directions.charAt(i) == "(") { floor_number++; } else { floor_number--; } } console.log(floor_number);

directions = $('pre').innerText; floor_number = 0; for (i = 0; i < directions.length; i++) { if (directions.charAt(i) == "(") { floor_number++; } else { floor_number--; } if (floor_number == -1) { console.log(i+1); break; } }
