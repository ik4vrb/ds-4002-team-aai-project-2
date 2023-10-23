# -*- coding: utf-8 -*-
"""
Created on Sat Oct  7 12:23:36 2023

@author: Owner
"""
    ### import libraries    

import pandas as pd
import cv2
import urllib
from urllib.request import Request, urlopen
import requests
from skimage import io
import numpy as np
from scipy.stats import entropy
import matplotlib.pyplot as plt
from PIL import Image
from collections import defaultdict
    ### trial run image

entropy_vals = []
num_of_colors_vals = []

# Gathers url info and provides two variables necessary values for 
def url_process(url):
     
    # Example of a URL that is being processed
    # url = 'https://theartwolf.com/wp-content/uploads/2021/06/Andy_Warhol_-_200-soup-cans_-_1962.jpg'
    
    print(url)

    raw_request = Request(url)
    raw_request.add_header('User-Agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0) Gecko/20100101 Firefox/78.0')
    raw_request.add_header('Accept', 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8')
    resp = urllib.request.urlopen(raw_request)
    image = np.asarray(bytearray(resp.read()), dtype="uint8")
    img = cv2.imdecode(image, cv2.IMREAD_COLOR)
    
    # print(img)

    # print("Image loaded...\n")
    
    #image_website = 
    
        ### complexity (entropy) trial run 
    
    gray_image = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    # print("Image has been grayed...\n")
        
    hist,bins = np.histogram(gray_image.ravel(), bins=256, range=(0, 256))
    
    prob_dist = hist/hist.sum()
    
    image_entropy = entropy(prob_dist, base=2)
    # print("Image entropy value: \n")
    entropy_vals.append(image_entropy)
    # print(image_entropy)
    
    plt.hist(hist, density=1, bins=256)
    # plt.show()
    
        # checks image bit
    #print(image.dtype)
    
        ### Colors trial run
    
    # cv2?
    test = np.array([[255,233,200], [23,66,122], [0,0,123], [233,200,255], [23,66,122]])
    image[test]
    
    # pil 
    
    # im = Image.open('CV_trial_run_jpeg.jpg')
    # im = Image.open('Andy_Warhol_-_200-soup-cans_-_1962.jpeg')
    
    im = Image.fromarray(img)
    
    by_color = defaultdict(int)
    for pixel in im.getdata():
        by_color[pixel] += 1
    # print("Length by color values: \n")
    num_of_colors = len(by_color.values())
    # print(len(by_color.values()))    
    num_of_colors_vals.append(num_of_colors);

painting_url_data = pd.read_csv("Image links - Sheet1.csv")
image_urls = painting_url_data['image_url'].to_numpy()
# print(image_urls)

for image_url in image_urls:
    url_process(image_url)

painting_url_data['Entropy Values'] = entropy_vals
painting_url_data['Number of Colors'] = num_of_colors_vals

painting_url_data.to_csv('Image_URL_Data.csv')
