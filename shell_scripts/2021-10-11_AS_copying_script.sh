#!/bin/bash -eEx
#SBATCH -t 00-08:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J AS_File_moving
#SBATCH --mem=64gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=anita.scoones@earlham.ac.uk

#2021-10-11

###Hey Anita, apologies if this is condescending but I normally find it easier
###to give people all the information and let them filter out what they actually
###need from anything. Hashed stuff apart from above is my comments, unhashed is
###the actual script.

#All the stuff at the top is the parameters given to Slurm, which handles jobs
#automatically on the cluster. I've just used time (-t) and memory (--mem) values
#from a script of mine anyway; you can change these to be larger or smaller as
#you would want

#Below is a bash function, this one will operate if the job fails and will do
#two things. One is print a line in the slurm error file which says exactly
#which line of the script the job failed at, the other is email me with the
#message in the mail command after the <<<
#You can remove this after the job works if you wanted to use this script as a
#basis for your own in the future
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
  mail -s 'AS Copy job failed' peter.osborne@earlham.ac.uk <<< "AS copy job failed"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR
#I really like bash functions, but they are a bit weird when compared to other
#or proper languages like python. If you want to define a bash function you
#do it like this (minus the hashes of course):
#function() {
#  commands to execute
#}
#Make sure that the commands inside the function are tabbed in, just like with
#a loop as well.

#The bit below makes two variables, named 'origin_point' and 'destination'. In Bash,
#you can define a variable like this by just giving a name and then saying what
#it equals.

#In this case, the "$1" and "$2" are positional arguments. The command to run this
#script is $0, so $1 is the very next thing you type after the sbatch script.sh,
#and $2 would be the thing after that. E.g. sbatch hello.sh olddir newdir would
#mean that origin_point would have the value olddir and destination would have
#the value newdir. You don't have to put them in speech marks, but I reaaaally
#recommend it, otherwise it can't handle things which have spaces or forward/
#backslashes in them - like a path would for instance.
origin_point = "$1"
destination = "$2"

#I'm also going to put the actual paths here, but since the variables are hashed
#out at the start of the line they are not actually run as code, this is mostly
#just so I have them somewhere handy if needed for this job. If the hash were to
#be removed by accident, then since the lines below come after the ones above they
#would overwrite the values the variables were given by $1 and $2. This can sometimes
#be useful, if you didn't need a file or directory again after it had been used
#at an earlier point in the script and didn't want to come up with a new variable name.

#origin_point = "/ei/data/reads_transfer/I_Macaulay_Group/Data_Package_Batch_05_10_2021"
#destination = "/ei/projects/4/4456a7ba-d392-40e0-b8a4-69c2f74e8210/data/raw/pips/ccs"

#I like to add a printout of my variables to a script so I can check what they
#ended up being in the slurm output; so the command below will print the statement
#in the speech marks, but replace the variable names with their actual values -
#so should have two directory paths. The \n means put in a new line, like pressing
#enter in a word processor and \t means put in a tab. I just use them as I like
#it all formatted this way but you don't actually have to.
printf "\nWill copy files in directory:\t$origin_point\tTo directory:\t$destination\n"

#Now the script will move to the directory which has all the files in it, nothing
#special here just the cd command to change directory, but using the variable
#instead of the path so you don't have to write out the path every time. It also
#means you can change what the script works on by just changing the value you
#give the variable rather than having to change the path everywhere in the script.
#This is why I like to use variables, plus when you get more familiar with bash
#you can have scripts make variables to give to other scripts automatically
cd "$origin_point"

#Now I am going to make a variable which contains all the files in this directory.
#This is my preferred way of doing things, but is by no means the only or even
#the best way.

target_files=$(find -maxdepth 1 -type f)

#The variable above is made from the output of a command. You can do this with
#most commands if you put it inside those brackets and after a dollar sign. For
#instance you could make a variable called list_of_contents which contained the
#same value as if you had just typed ls by doing list_of_contents=$(ls). Some
#commands this doesn't work, but they tend to be ones you would expect. You wouldn't
#expect list_of_contents=$(cd /hpc-home/osbourne) to work for instance since there
#isn't an output, it actually does something instead.

#For the actual target_files variable, it runs the find command with some filtering.
#Find works as the name suggests, it finds files or directories depending on what
#filtering steps you give it. Here I give it a -maxdepth 1 and -type f. These
#mean it will only look in the current directory (-maxdepth 1), if you had sub-directories
#you wanted it to search you would give it a bigger number - think of it like saying
#how many splits along a tree branch it should search down. It also tells it to
#only find files (-type f) as it searches. You could use -d instead to only find
#directories if you wanted. Both these are not necessary in this exact copying job,
#since you only have files and no sub-directories, but I find it safer to include
#these and might be useful for the future

for f in $target_files
do
  target=$(basename "$f")
  cp "$target" "$destination" && printf "\nCopied file:\t$target\tto directory:\t$destination\n"
done

#The above is the simplest and likely slowest way of copying files. It loops over
#all the files in the variable called target_files then for each it gets just the
#basename of it (this means instead of it being ./filename it will just be filename)
#which makes it much easier to handle with commands since otherwise it breaks trying
#to find a file which has the slash and period in their name. It puts this basename
#output into a variable called 'target' and then copies it to the 'destination'.
#The destination variable stays the same since it is defined outside the loop
#earlier on in the script, but the 'target' changes each time with each new file
#the loop is working on. This is good as it means we can use the same command
#with the variable name in it and it just puts in the right file each time.

#The && printf command I add as a more primitive error check, since the double
#ampersands mean the command after it will only occur if the command before it
#worked. So here the text will only print if the copying command actually worked.

mail -s "File copying job finished" anita.scoones@earlham.ac.uk <<< "The copying job has completed. The script is over"
#Above added just as an example of how you can use the cluster to email yourself
#or someone else. The mail command is builtin and easy to use but there are others
#you can install or use instead. -s "Whatever" is the subject, then you can also
#have -a file.pdf to attach a file (you can give a path to a file anywhere, doesn't have to be a pdf),
#then the email address to send the message to. The actual text of the email you write
#after the <<< and it must be inside speech marks.

###New to me method
###What I was testing instead of just sending the simple script
###If you want to use it, remove the hashes in the commands below but not the
###dangerous bit
#source package /tgac/software/testing/bin/rsync-3.1.1
#rsync -vha "$origin_point" "$destination"
###The above loads the rsync tool on the cluster and uses it for copying.
###What it actually does is makes the two directories the same, so here it is
###making the destination directory the same as the origin_point directory by
###copying over the files from the origin to the destination. The -vha are
###options (also called flags) which tell the command to work in a particular
###way. Here they ask it to monitor the transfer and print it in a human readable
###form (the v and h options) as well as run it in archive mode which basically
###means the files are identical (means some other things as well but not relevant here, you can look them up yourself when you are doing your own coding)


###DANGEROUS script option
###Don't recommend this but is the quickest albeit riskiest way of just moving
###files
#cd "$origin_point"
#for f in $target_files
#do
#  target=$(basename "$f")
#  mv "$target" "$destination" && printf "\nMoved file:\t$target\tto directory:\t$destination\n"
#done
###The above doesn't copy the files, it just directly moves them. Is riskier since
###you don't keep the original copies but under other circumstances can be fine
###and when you are doing your own coding is the normal approach to moving files.
