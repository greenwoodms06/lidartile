import bpy
import os
from mathutils import Vector
import math

# Path to the folder containing STL files
folder_path = r"E:\lidartile\temp"

# Function to import STL files
def import_stl(file_path):
    bpy.ops.import_mesh.stl(filepath=file_path)

# Function to arrange objects in a non-overlapping matrix
def arrange_objects_in_matrix(objects, singleRow=False):
    # Calculate the number of rows and columns
    num_objects = len(objects)
    
    if singleRow:
        cols = num_objects
        rows = 1
    else:
        cols = math.ceil(math.sqrt(num_objects))
        rows = math.ceil(num_objects / cols)

    # Calculate spacing between objects
    max_dimension = max(obj.dimensions.length for obj in objects)
    spacing = max_dimension * 1.1

    # Starting position
    start_pos = Vector((-cols * spacing / 2, rows * spacing / 2, 0))

    # Loop through objects and position them
    for i, obj in enumerate(objects):
        col = i % cols
        row = rows - 1 - i // cols  # Invert row index for proper arrangement
        if singleRow:
            pos = start_pos + Vector((col * spacing, -row * 0, 0))
        else:
            pos = start_pos + Vector((col * spacing, -row * spacing, 0))
        obj.location = pos

# Clear existing objects
bpy.ops.object.select_all(action='DESELECT')
bpy.ops.object.select_by_type(type='MESH')
bpy.ops.object.delete()

# Import STL files
stl_files = [f for f in os.listdir(folder_path) if f.endswith('.stl')]
for stl_file in stl_files:
    file_path = os.path.join(folder_path, stl_file)
    import_stl(file_path)

# Select all imported objects
bpy.ops.object.select_all(action='DESELECT')
bpy.ops.object.select_by_type(type='MESH')

# Arrange objects into a matrix
bpy.ops.object.select_all(action='SELECT')
selected_objects = bpy.context.selected_objects
arrange_objects_in_matrix(selected_objects)#, singleRow=True)