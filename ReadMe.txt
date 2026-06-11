How to Test EEG-AdaBoost-20F on Your Own Dataset

Follow the steps below to apply the EEG-AdaBoost model (20 features) for seizure detection and forecasting on a single-channel EEG dataset.

1. Generate Baseline (BL) Features
Use generate_BL.m to compute baseline features for your single-channel EEG data.
The function do_bandpass_filtering.m is adapted from the NEURAL: quantitative features for newborn EEG using Matlab toolbox.

2. Feature Extraction (20-second Segments)
Use features_extration.m to extract features from EEG segments.

3. Annotation Guidelines

Seizure Detection:
Label each 20 s EEG segment.
If a seizure lasts more than 10 seconds within the segment, label it as seizure.

Seizure Forecasting:
Label a segment as predicted seizure if a seizure occurs within the next predefined prediction interval (recommended 10 min).

4. Data Splitting and Evaluation Strategy

The framework supports multiple evaluation strategies, including subject-independent leave-one-subject-out (LOSO) validation and standard train–test splits.

In the default implementation (main_seizure_detection.m and main_forecasting_seizure.m), evaluation is performed in a LOSO-like manner, where data from one subject (or neonate) is held out for testing while all remaining subjects are used for training.

For each test subject, features are extracted and evaluated independently, simulating real-world clinical inference on unseen patients.

Users may also implement alternative splitting strategies (e.g., k-fold or random splits), but must ensure strict subject-level separation.

5. Prepare Input Files

Create the following .xlsx files:

For Detection:
Training_features_detection_annotation.xlsx
For each 20s EEG Columns: extracted features (Step 2)
Last column: annatated label (Step 3)

For Forecasting:
Training_features_forecasting_annotation_10_predicted_interval.xlsx
Same structure as above
Last column: forecasting label

5. Run Seizure Detection
Execute:
main_seizure_detection
6. Run Seizure Forecasting
Execute:
main_forecasting_seizure
