def main():
    # Read in
    infile = open('data.txt')
    f = open('output.txt', 'a')
    # read in item names
    sum = 0
    line = infile.readline()
    val, year = line.split()
    sum += float(val)
    data = []
    y = []
    data.append(val)
    y.append(year)
    # get item data
    #j = 1
    for line in infile:
        print(line)
        #val, year = line.split()
        #print(val + " : " + year)
        #sum += float(val)
        #j += 1
        #if(j == 12):
        #    sum = round(sum/12, 4)
        #    f.write(str(sum))
        #    f.write(" ")
            #f.write(year)
        #    f.write("\n")
        #    j = 0
        #    sum = 0
        val, year = line.split()
        data.append(val)
        y.append(year)
    i = 0
    while i < len(data)-1:
        val2 = int(data[i])
        val1 = int(data[i+1])
        if(val2-val1 > 0):
            f.write("y")
            #f.write(" ")
            #f.write(y[i])
            f.write("\n")
        else:
            f.write("n")
            #f.write(" ")
            #f.write(y[i])
            f.write("\n")
        i += 1

    print(data)
    f.close()
main()