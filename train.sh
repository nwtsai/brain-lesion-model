#!/bin/sh

# Variables
lesions="lesions"
MRIscans="MRIscans"
error=false
max_epochs=200

# Set max_epochs variable only if specified
if [ ! -z "$1" ]; then
	if [ "$1" -eq "$1" ] 2>/dev/null; then
		max_epochs=$1
	else
		echo "Error: correct usage is ./train.sh [max_epochs] where max_epochs must be an integer"
		error=true
	fi
fi

# Check if required directories exist
if [ ! -d "$MRIscans" ]; then
	echo "Error: folder 'MRIscans' does not exist. Please create a MRIscans folder populated with MRI brain scan files (.png)"
	error=true
fi
if [ ! -d "$lesions" ]; then
	echo "Error: folder 'lesions' does not exist. Please create a lesions folder populated with isolated brain lesions images (.png)"
	error=true
fi

# Exit the script if an error exists
if [ "$error" = true ]; then
	exit
fi

# Remove old folders
rm -rf processed
rm -rf processed_train
rm -rf processed_test

# Creating side by side images
python model/tools/process.py --input_dir $lesions --output_dir processed --b_dir $MRIscans --operation combine

# Splitting images into non-overlapping training and testing data sets
python model/tools/split.py --dir processed

# Training the machine learning model with the training data set
python model/model.py --mode train --input_dir processed/train --output_dir processed_train --which_direction BtoA --max_epochs $max_epochs

echo "Success: run ./test.sh to test the model"
