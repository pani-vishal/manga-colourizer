import os
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from tqdm import tqdm
import cv2
from PIL import Image

path_root = ".."
path_data = os.path.join(path_root, "data", "ds_debug")
path_panels = os.path.join(path_root, "data", 'panels')

list_chapters = sorted(os.listdir(path_data))

if not os.path.exists(path_panels):
    os.mkdir(path_panels)

for chapter in tqdm(list_chapters):
    path_chapter = os.path.join(path_data, chapter)
    path_chapter_panels = os.path.join(path_panels, chapter)
    path_csvs = os.path.join(path_chapter, 'csv')

    if not os.path.exists(path_chapter_panels):
        os.mkdir(path_chapter_panels)

    list_csvs = sorted(os.listdir(path_csvs))
    list_imgs = [csv[:-4] + '.png' for csv in list_csvs]
    
    for csv, img in zip(list_csvs, list_imgs):
        df = pd.read_csv(os.path.join(path_csvs, csv))
        for idx_panel in range(len(df)):
            (x1,x2,x3,x4,y1,y2,y3,y4) = df.iloc[idx_panel]
            xs = np.array([x1,x2,x3,x4])
            ys = np.array([y1,y2,y3,y4])
            coords = np.vstack((xs,ys)).T
            coords = np.expand_dims(coords, axis=0)

            # original image
            # - 1 loads as-is so if it will be 3 or 4 channel as the original
            image = cv2.imread(os.path.join(path_chapter, img))
            image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
            # mask defaulting to black for 3-channel and transparent for 4-channel
            # (of course replace corners with yours)
            mask = np.zeros(image.shape, dtype=np.uint8)
            coords = np.array(coords, dtype=np.int32)
            # fill the ROI so it doesn't get wiped out when the mask is applied
            channel_count = image.shape[2]  # i.e. 3 or 4 depending on your image
            ignore_mask_color = (255,)*channel_count
            cv2.fillConvexPoly(mask, coords, ignore_mask_color)
            # from Masterfool: use cv2.fillConvexPoly if you know it's convex

            # apply the mask
            # TODO convert remaining values to -1 (invalid)  
            mask_inverse = 255 - mask
            masked_image = cv2.bitwise_or(image, mask_inverse)

            bounds_min = np.squeeze(coords.min(axis=1))
            bounds_max = np.squeeze(coords.max(axis=1))
            masked_image = masked_image[bounds_min[1]: bounds_max[1], 
                                        bounds_min[0]: bounds_max[0], 
                                        :]

            name_panel = chapter + f'_{img[:-4]}_{idx_panel}.png'
            image = Image.fromarray(masked_image)
            image.save(os.path.join(path_chapter_panels, name_panel))


