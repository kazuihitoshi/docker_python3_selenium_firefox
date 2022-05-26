from selenium import webdriver
import time
options = webdriver.FirefoxOptions()
options.add_argument('--headless')
driver = webdriver.Firefox(options=options) 

driver.get('https://www.google.com/')

search_box = driver.find_element_by_name("q")
search_box.send_keys("FirefoxDriver")
search_box.submit()

timeout = time.time() + 60
while time.time() < timeout :
    result = driver.find_elements_by_css_selector('.d6cvqb')
    if len(result) > 0 :
        break

driver.save_screenshot('search_results.png')
driver.quit()
