start_value = 1000000
elements = []

# Generate the elements in decreasing order
for i in range(start_value, 1, -1):
    elements.append(i)

# Write the elements to the output.txt file
with open('input.txt', 'w') as file:
    for element in elements:
        file.write(f"i {element}\n")
    for element in elements:
        file.write("d\n")
        file.write("m\n")
