function get_index( x, y )
    return 300 * ( x - 1 ) + y;
end

print(get_index( 1, 1 ))
print(get_index( 1, 100 ))
print(get_index( 1, 200 ))
print(get_index( 1, 300 ))
print(get_index( 2, 1 ))
print(get_index( 2, 100 ))
print(get_index( 2, 200 ))
print(get_index( 2, 300 ))
print(get_index( 3, 1 ))
print(get_index( 300, 300 ))