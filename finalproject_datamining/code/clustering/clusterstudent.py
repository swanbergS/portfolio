'''
Sophia Swanberg
CSCE 364
Agglomerative Clustering
5 March 2021
-------------
This program will perform complete linkage
or single linkage based on user input. Complete linkage
computes distance based on the biggest cluster distance,
and single linkage computes distance based on the
smallest cluster distance.
-------------
'''

from __future__ import division
from collections import defaultdict

'''Provided code'''
# find the normalized distance
def nDistance(item1, item2, nvalue):
    if(nvalue == 0):
        return 0
    else:
        return round((((abs(item1 - item2))/nvalue)),2)

def singleLinkage(clusterDist, newClusterName, originalDist, clusterNames):
    # add to clusterDist new distances from new cluster to all other clusters
    # use closest distances between clusters
    print("in singleLinkage")
    for s1 in clusterNames:
        smallestD = 9999
        for cElem in s1:
            for ncElem in newClusterName:
                if float(originalDist[cElem][ncElem]) < float(smallestD):
                    smallestD = originalDist[cElem][ncElem]
        clusterDist[newClusterName][s1] = smallestD
        clusterDist[s1][newClusterName] = smallestD

'''Sophia Code'''
def completeLinkage(clusterDist, newClusterName, originalDist, clusterNames):
    '''
    :param clusterDist: dictionary of calculated cluster distances
    :param newClusterName: string that contains the new cluster name
    :param originalDist: dictionary of the original distances
    :param clusterNames: list that contains the names of the clusters
    :return: this function will add to clusterDist new distances from new cluster to all other clusters using
     the furthest distances between clusters (no return value)
    '''
    print("in completeLinkage")
    for s1 in clusterNames:
        largestD = originalDist[0][0]
        for cElem in s1:
            for ncElem in newClusterName:
                if float(originalDist[cElem][ncElem]) > float(largestD):
                    largestD = originalDist[cElem][ncElem]
        clusterDist[newClusterName][s1] = largestD
        clusterDist[s1][newClusterName] = largestD

def cluster(input, clusterNames, clusterDist, originalDist, loopctr):
    '''
    :param input: integer (1:single linkage, 2: complete linkage)
    :param clusterNames: list that contains the names of the clusters
    :param clusterDist: dictionary of calculated cluster distances
    :param originalDist: dictionary of the original distances
    :param loopctr: integer that counts the iterations
    :return: this function will complete agglomerative clustering based on the
    input of the user. It calls the singleLinkage function or the completeLinkage
    function. (no return value)
    '''
    while len(clusterNames) > 1:
        newClusterName = shortMerge(clusterDist, clusterNames)
        # add new cluster and distances to matrix
        print("\nAdd new cluster and distances to matrix")
        if(input == 1):
            singleLinkage(clusterDist, newClusterName, originalDist, clusterNames)
        else:
            completeLinkage(clusterDist, newClusterName, originalDist, clusterNames)
        clusterNames.append(newClusterName)
        print('iteration', loopctr)
        loopctr += 1

def shortMerge(clusterDist, clusterNames):
    '''
    :param clusterDist: dictionary of calculated cluster distances
    :param clusterNames: list that contains the names of the clusters
    :return: this function will find the shortest distance between two clusters
    in clusterDist. It will then merge the two clusters, i and j, together.
    Returns newclusterName
    '''
    shortestD = clusterDist[clusterNames[0]][clusterNames[1]]
    shortestI = clusterNames[0]
    shortestJ = clusterNames[1]
    for iName in clusterNames:
        for jName in clusterNames:
            if (iName != jName and float(clusterDist[iName][jName]) < float(shortestD)):
                shortestD = clusterDist[iName][jName]
                shortestI = iName
                shortestJ = jName
    # Sophia Addition:
    #print("clusterDist: ")
    #for key in clusterDist.keys():
    #    print("Key : {} , Value : {}".format(key, clusterDist[key]))

    # merge clusters i and j
    print("\nMerge Clusters I and J")
    newClusterName = shortestI +" "+ shortestJ
    print("newClusterName: ", newClusterName)
    print(clusterNames)
    clusterNames.remove(shortestI)
    clusterNames.remove(shortestJ)

    del clusterDist[shortestI]
    del clusterDist[shortestJ]

    klist = list(clusterDist.keys())
    for k in klist:
        k2list = list(clusterDist[k])
        for k2 in k2list:
            if (k2 == shortestI or k2 == shortestJ):
                del clusterDist[k][k2]
    return newClusterName

def distanceMatrix(itemsM, itemNames, originalDist, clusterDist, minimum, maximum, dimen):
    #calculates the distance matrix
    '''
    :param itemsM:
    :param itemNames:
    :param originalDist: dictionary of the original distances
    :param clusterDist: dictionary of calculated cluster distances
    :param minimum: dictionary that holds the min of each dimension
    :param maximum: dictionary that holds the max of each dimension
    :param dimen: integer of the current dimension
    :return: this function calculates the distance matrix. It was based on
    the distance calculation method provided in the clusterstudent.py code, but it
    was adjusted to work with a 2D list.
    '''
    ctr = 0
    while(ctr < len(itemNames)):
        hold = itemsM[ctr]
        r = 0
        while(r < len(itemNames)):
            hold2 = itemsM[r]
            if itemNames[ctr] == itemNames[r]:
                d = 0
            else:
                i = 0
                d = 0
                while i < dimen-1:
                    min = minimum[i]
                    max = maximum[i]
                    d += nDistance(hold[i], hold2[i], (max-min))
                    i += 1
            originalDist[itemNames[ctr]][itemNames[r]] = round(d/dimen, 2) #i used the approach you did in the spreadsheet
            clusterDist[itemNames[ctr]][itemNames[r]] = round(d/dimen, 2)
            r += 1
        ctr += 1

def minmax(dimen, itemNames, itemsM, minimum, maximum):
    '''
    :param dimen: integer of the current dimension
    :param itemNames: list of the names of the items
    :param itemsM: list of the values of the items
    :param minimum: dictionary that holds the min of each dimension
    :param maximum: dictionary that holds the max of each dimension
    :return: this function will calculate the min and the max of each
    dimension and stores the values in their corresponding dictionary
    with the key being the dimension it was found in (no return value)
    '''
    ctr = 0
    while ctr < dimen-1:
        print("ctr: ", ctr)
        val = listTraverse(itemsM, itemNames, ctr)
        print(val)
        min = val[0]
        max = val[0]
        r = 0
        while r < len(val):
            if val[r] < min:
                min = val[r]
                print("min: ", min)
            elif val[r] > max:
                max = val[r]
                print("max: ", max)
            minimum[ctr] = min
            maximum[ctr] = max
            r += 1
        ctr += 1

def listTraverse(itemsM, itemNames, ctr):
    '''
    :param itemsM: list of the values of the items
    :param itemNames: list of the names of the items
    :param ctr: integer counter
    :return: this function will traverse the itemsM list and
    return a list of items at subset ctr
    '''
    hold = []
    for r in range(len(itemsM)):
        val = itemsM[r][ctr]
        hold.append(val)
    return hold

def main():
    # Initialization and Read in Sequences
    originalDist = defaultdict(lambda: defaultdict(int))
    clusterDist = defaultdict(lambda: defaultdict(int))
    itemsM = []
    #Sophia addition
    minimum = defaultdict(lambda: defaultdict(int)) #holds min vals
    maximum = defaultdict(lambda: defaultdict(int)) #holds max vals
    dimen = 0
    lines = 0

    #Read in
    infile = open('clusterdata.txt', 'r')
    # read in item names
    line = infile.readline().rstrip('\n')
    itemNames = line.split(' ')
    # get item data
    j = 0
    for line in infile:
        hold = []
        if(dimen == 0):
            for i in line.split():
                hold.append(float(i))
                dimen += 1
        else:
            for i in line.split():
                hold.append(float(i))
        itemsM.append(hold)
        j += 1
    #dimen = len(itemsM)-1
    #dimen = len(itemNames)
    print("dimen: ", dimen)
    #calculate min and max
    minmax(dimen, itemNames, itemsM, minimum, maximum)
    #prints the min and max of each dimension
    print("min: ")
    for key in minimum.keys():
        print("Key : {} , Value : {}".format(key, minimum[key]))
    print("max: ")
    for key in maximum.keys():
        print("Key : {} , Value : {}".format(key, maximum[key]))

    #construct distance matrix
    distanceMatrix(itemsM, itemNames, originalDist, clusterDist, minimum, maximum, dimen)
    clusterNames = itemNames
    loopctr = 1
    print(itemNames)
    print(itemsM)

    #inital cluster distance (printed with every iteration)
    #print("clusterDist: ")
    #for key in clusterDist.keys():
    #   print("Key : {} , Value : {}".format(key, clusterDist[key]))


    #Step 2: Perform Agglomerative Clustering
    userinput = int(input("Enter 1 for Single Linkage\n2 for Complete Linkage\n"))
    cluster(userinput, clusterNames, clusterDist, originalDist, loopctr)
    print("clusternames: ", clusterNames)

main()