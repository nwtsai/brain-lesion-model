# Brain Lesion Segmentation #

### Nathan Tsai - 304575323 ###
### Bradley Zhu - 304627529 ###

## Note ##
* The trained model and the image datasets have been shared with the instructor directly and will not be shared on this repository
* If you would like to train a local copy of the model, running ./train.sh and ./test.sh should suffice provided you supply your own 'lesions' and 'MRIscans' datasets

## Introduction ##
* We created a conditional adversarial network model that identifies, analyzes, and isolates brain lesions from MRI scans
* Brain lesions simply mean any abnormal brain tissues that appear as bright spots on the brain in MRI scans
* The goal of this project is to increase doctors' diagnosis accuracies relating to identifying unhealthy brain tissues
* This increases the likelihood of successfully identifying and treating brain abnormalities while preventing unnecessary brain surgeries if the tissue was actually healthy 

## Training and testing the model ##
* Obtain MRI scans of brain scans and save them in a folder named 'MRIscans'
	* See 'MRIscans' directory for MRI image examples
* Manually isolate the brain lesions from the images and save them in a folder named 'lesions'
	* See 'lesions' directory for isolated brain lesion examples
* Run ./train.sh to train the custom model 
* Run ./test.sh to test the custom model
* Open processed_test/index.html in your default browser to view the brain scan, model's guess, actual isolated lesion, and the accuracy measured against the SSIM index between the guess and the true lesion

## Model Results ##
![alt tag](https://i.imgur.com/fSzn14P.png)
![alt tag](https://i.imgur.com/VOY7hCA.png)

## Sources and Dependencies ##
* Utilized [Materialize](https://materializecss.com) to design the displayed HTML results
	* Materialize is a design language created by Google for constructing elegant user experiences
* Modified the code of [pix2pix](https://github.com/affinelayer/pix2pix-tensorflow/blob/master/pix2pix.py), a tensorflow model for images
	* Altered the splitting, training, and testing portion of the code to tailor the model to learn brain lesion segmentations
	* Fine-tuned the parameters of the model to suit our custom MRI scans
	* Model outputs a file in processed/index.html which displays the final test results
		* Results display brain scan, model's guess of where the lesion is, and the actual isolated lesion
* Incorporated [pyssim](https://github.com/jterrace/pyssim) to test the Structural Similarity Image Metric (SSIM) between the model's guess and the ground truth
	* ./test.sh automatically computes the accuracy between all guesses and actual lesions
	* Once computed, the script updates processed_test/index.html with the corresponding accuracies
