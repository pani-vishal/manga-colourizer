import os
from PIL import Image
import numpy as np
from tqdm import tqdm

split_thres = 781
path_root = ".."
path_data = os.path.join(path_root, "data", "ds_debug")

list_chapters = os.listdir(path_data)

for chapter in tqdm(list_chapters):
    path_chapter = os.path.join(path_data, chapter)
    list_pages = [  
                    page for page in os.listdir(path_chapter)
                    if os.path.isfile(os.path.join(path_chapter, page))
                 ]
    
    for page in list_pages:
        path_page = os.path.join(path_chapter, page)
        img = Image.open(path_page)
        img_np = np.asarray(img)
        if img_np.shape[1] > split_thres:
            img_1 = img_np[:,:split_thres,:]
            img_2 = img_np[:,split_thres:,:]
            img_1 = Image.fromarray(img_1)
            img_2 = Image.fromarray(img_2)
            img_1.save(path_page[:-4] + "_1.png")
            img_2.save(path_page[:-4] + "_2.png")
            os.remove(path_page)
