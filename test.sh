#!/bin/sh

# Remove the old testing directory
rm -rf processed_test

# Testing the model with the testing data set
python model/model.py --mode test --input_dir processed/val --output_dir processed_test --checkpoint processed_train

# Comparing the Structural Similarity Image Metric (SSIM) between each guess and each corresponding ground truth
cd ./processed_test/images

# Sorting the output and target files
outputs=( $(find . -name "*-outputs.png") )
IFS=$'\n' 
sorted_outputs=($(sort <<<"${outputs[*]}"))
unset IFS

targets=( $(find . -name "*-targets.png") )
IFS=$'\n' 
sorted_targets=($(sort <<<"${targets[*]}"))
unset IFS

# Finding pairs of images and calculating SSIM between each image, then updating index.html
for((i=0;i<${#outputs[@]};i++)); do
	output_file=${sorted_outputs[$i]}
	target_file=${sorted_targets[$i]}
	image_id=${output_file:2:5}
	suffix="-accuracy"
	accuracy="$(pyssim ${sorted_outputs[$i]} ${sorted_targets[$i]})"
	sed -i.bak s/$image_id$suffix/$accuracy/g ../index.html
	echo "$image_id accuracy: $accuracy"
done

echo "Success: open processed_test/index.html to view the results"
