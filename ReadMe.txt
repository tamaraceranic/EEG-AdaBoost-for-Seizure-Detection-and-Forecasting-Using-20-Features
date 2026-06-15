How to Test EEG-AdaBoost-20F on Your Own Dataset

Follow the steps below to apply the EEG-AdaBoost model (20 features) for seizure detection and forecasting on a single-channel EEG dataset.

Pipeline: Baseline estimation: baseline feature estimation from selected non-seizure EEG time series
          Main pipeline: EEG segmentation into 20-second windows → band-pass filtering (preprocessing) →  feature extraction → AdaBoost classifier → prediction              output (seizure detection or seizure forecasting).

1. Generate Baseline (BL) Features
Use generate_BL.m to compute baseline features from selected non-seizure single-channel EEG recordings.
Input:
Single-channel non-seizure EEG time series
Sampling frequency (fs)
Output:
Averaged features per 20-second segments of selected non-seizure EEG recordings
The function do_bandpass_filtering.m is adapted from the NEURAL toolbox for quantitative neonatal EEG feature extraction in MATLAB.

2. Feature Extraction (20-second Segments)
Use features_extration.m to extract features from EEG segments. 
Input: single-channel EEG time series, and sampling frequency (fs). 
Output: A matrix containing the extracted 20 EEG features for each 20-second EEG segment (one row per segment)

3. Annotation Guidelines
Seizure Detection
Label each 20-second EEG segment.
A segment is labeled as seizure if a seizure lasts more than 10 seconds within that segment.
Seizure Forecasting
A segment is labeled as pre-seizure (positive prediction) if a seizure occurs within the next predefined prediction horizon (recommended: 10 minutes).

4. Data Splitting and Evaluation Strategy

The framework supports multiple evaluation strategies, including subject-independent leave-one-subject-out (LOSO) validation and standard train–test splitting.

In the default implementation (main_seizure_detection.m and main_forecasting_seizure.m), evaluation is performed using a LOSO strategy, where data from one subject (neonate) is used for testing while all remaining subjects are used for training.

For each test subject, features are extracted and evaluated independently, simulating real-world clinical deployment on unseen patients.

Users may also apply alternative evaluation strategies (e.g., k-fold cross-validation or random splits), provided that strict subject-level separation is maintained to avoid data leakage.

5. Prepare Input Files

Create the following .xlsx files:

For Seizure Detection

Training_features_detection_annotation.xlsx

Each row corresponds to a 20-second EEG segment
Columns 1–20: extracted features (Step 2)
Last column: annotated seizure label (Step 3)
For Seizure Forecasting

Training_features_forecasting_annotation_10min.xlsx

Same structure as above
Last column: forecasting label

6. Run Seizure Detection

We use an AdaBoostM1 classifier with decision trees (max depth = 3) as weak learners and 300 boosting iterations.
Model parameters are provided based on strong performance on the available dataset. Users may further tune hyperparameters for their own datasets if needed.

Execute:
main_seizure_detection

7. Run Seizure Forecasting
Execute:
main_forecasting_seizure
