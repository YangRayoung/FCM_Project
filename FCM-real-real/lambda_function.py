
# coding: utf-8

# In[ ]:


import json
import logging
import pymysql
import sys
import datetime
 
#rds settings
rds_host  = "fcmdb.cahco6pth77g.ap-northeast-2.rds.amazonaws.com"
name = "FCM_RDS"
password = "wjdxhd0603~!"
db_name = "FCM"
 
logger = logging.getLogger()
logger.setLevel(logging.INFO)
 
try:
    conn = pymysql.connect(rds_host, user=name, passwd=password, db=db_name, connect_timeout=5)
except:
    logger.error("ERROR: Unexpected error: Could not connect to MySQL instance.")
    sys.exit()
    
    
def waste_location(location):
    location_str = {
        1:'A_amount',
        2:'B_amount',
        3:'C_amount',
        4:'D_amount',
        5:'E_amount'
    }
    return location_str.get(location)
 
 
def lambda_handler(event,context):
    result=[]
    now = datetime.datetime.now()
    newD = now.strftime('%Y-%m-%d')
    newR = event['remain']
    number = event['wastebin']
    location = waste_location(number)
    
    with conn.cursor() as cur:
        try:
            cur.execute('INSERT INTO '+location+' (remain, date) VALUES (%s, %s)',(newR, newD))
        except:
            print('duplicated->update')
            cur.execute('UPDATE '+location+' SET remain = %s WHERE date = %s', (newR, newD))
        
        logging.info("location : " + location + " / remain : "+str(newR))
        
        rows = cur.fetchall()
        for row in rows:
            print(row)
            result.append(row)
        
        conn.commit()
    print(result)

