# 1) What is the most popular pair of heroes (often appearing together in the comics)?
echo "1) The most popular pair of heroes are:"
awk 'BEGIN {FS=","; OFS = "\t"} NR==1 {print "heroes", "appereances"}' hero-network_clean.csv
cat hero-network_clean.csv | p.df 'df["most_frequent_app"]=df["hero1"]+df["hero2"]' 'df["most_frequent_app"].value_counts()' 'df["most_frequent_app"].sort_values(ascending=False)' 'df.reset_index()' | head 

printf "\n"

# 2) Number of comics per hero:
echo "2) Number of comics per hero:"
awk 'BEGIN{FS= ","; OFS = "\t"} NR==1 {print "hero", "comic"}' edges_clean.csv
datamash -t, -s groupby 1 count 2 < edges_clean.csv | sort -t, -k 2 -nr | head 

printf "\n"

# 3) The average number of heroes in comics:
echo "3) Average numer of heroes in comics:"
awk -F, '{comics[$2]++} END {for (comic in comics) {count += comics[comic]}; print count/length(comics)}' edges_clean.csv

#the 3rd script in pandas gives 7.59, with awk 6.89, but the code should grouping and counting in the right way.
