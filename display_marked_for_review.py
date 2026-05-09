import os

def create_file(fields, answers,file_path):
    file = open(file_path,"w")
    file.write("The following fields have been marked for manual review:\n")
    file.write("fields, answers\n")

    for i in range(len(fields)):
        file.write("{}, {}\n".format(fields[i],answers[i]))

    file.close()

def display_file(file_path):
    os.system(file_path)

