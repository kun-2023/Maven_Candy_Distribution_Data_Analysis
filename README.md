# Maven Candy Distribution Data Analysis
<h2>Table of Content</h2>
<ul>
<li>Case Description</li>
<li>Datasets Description</li>
<li>Executive Summary</li>
<li>DeepDives</li>
<li>Recommandations</li>
<li>Tableau Dashboard</li>
</ul>
<h2>Case Descriptions</h2>
<p>Maven Candy Distribution is an American candy distribution company selling 15 products in chocolate, sugar and others. Its domestic businesses operate in 49 States and 531 cities across regions such as Pacific, Atlantics, Interiors and Gulf. It manufactures their products from their own 5 factories. The company’s orders had been robust and experiencing a growth between 2021-01-03 and 2024-12-31. All those orders are expected to be delivered between 2026-06-30 and 2030-06-28. However, the company wants to assess their operations efficiency and find a way to improve the profit margin. This data analysis will be looking at company’s order sales, gross profit, and margins across multiple dimensions such as year, geographies, product divisions, manufactures. The report will be revealing the products, operations, manufactures with highest margins and those with the lowest margins. At the end, a recommendation will be given on what kinds of products should the company promote and sell in order to improve sales and margins. This data analysis was done in <b>SQL</b>. The dashboard was built in **tableau**.</p>
<h2>Dataset Desription</h2>
<p>This is a 5-table dataset. It’s downloaded from Maven data playground. It includes data on factories, products, sales from 2021-01-03 to 2024-12-31, sales target on 2024 sales, and zip codes. Here is a glance.</p>

![datasets](https://github.com/user-attachments/assets/eebcef7b-a793-48ca-96f5-8e9b5b85ee82)


<h2>Executive Summary</h2>
<p>Maven Candy Company had a total order of 138830.34 dollars for the 37873 orders made from 2021 to 2024. It has a total cost of 47322.11 dollars and a total gross of 91508.23 dollars; therefore, it enjoys a gross margin of 65.91%. For the annual performance, each year has experienced sales growth. Strong growth of over 20% for 2023 and 2024. For each year, the profit margin was between 65% and 67%.  In terms of divisions, chocolate had the highest sales and the highest margins. However, sugar not only has the lowest shares but also the lowest profit margin of 44%. Top 10 states count for 70% of total orders.</p>

<h2>Deep Dives</h2>
<p><b>Annual sales trends</b>. For the annual sales, the annual sales are 28011.91, 28630.73, 36228.55, 45959.35 dollars; the annual order units are 7581, 7979, 9837, 12476; the annual costs are 9674.3, 9672.01, 12310.04, and 15665.76 dollars; the annual gross profits are 18337.61, 18958.72, 23918.31, 30293.59 dollars all for the year 2021, 2022, 2023, 2024 respectively.  The sales growth was 2.16%, 20.97% and 21.17%; the gross profit growth was 3.28%, 20.74%, and 21.04% all for 2022, 2023, 2024 respectively. On the average basis, average sale was up 3.06%, down 2.45%, flat; average cost up 5.79%, down 3.2% and down 0.79%; average gross profit was up 1.68%, down 2.06%, and stay flat in 2022, 2023 and 2024. </p>

![sales_kpi](https://github.com/user-attachments/assets/aaf740bb-d865-42ba-828d-a3dc04c5d3d6)

![annual_sales](https://github.com/user-attachments/assets/03a602d8-cb86-4ee9-a7d2-5d93dde5f9e1)
![average_unit_change](https://github.com/user-attachments/assets/924e4694-4498-411e-8675-529cc4e5f7d2)

<p><b>States Sales</b>. Top 3 states with the most orders are California, New York, and Texas. Top 10 states own 70.11 percent of the total orders. Top 10 states gross margins range above 65% except Arizona with gross margin of 63.33%. For the top 10 cities, 3 of them come from California, 2 of them come from Texas. </p>

![top_10_state_2](https://github.com/user-attachments/assets/7fd78b06-34ba-4688-8543-66b5bf05dd11)

![top_10_states](https://github.com/user-attachments/assets/7de80fa9-9931-49b5-88cb-309b99acdbe1)

![top10_cities](https://github.com/user-attachments/assets/6f2ab260-453d-48e9-a5c9-96f0b3104e7f)



<p><b>Ship mode</b>. There are four ship classes. Standard, Second, First, and Same Day. 60% of the backlogs would be from standard class, 20% from second class, 15% from the first class, and 5% from same day. All the ship classes had orders for cities in all different regions.

![ship_mode](https://github.com/user-attachments/assets/f171345b-c825-49f0-9a24-34d5e5ebfeb5)

</p>
<p><b>Product sales</b>. In terms of divisions, chocolate has 92.93% of the shares with a margin of 67.45%, followed by other of 6.76% of shares and a margin of 44.69%, and sugar of 0.31% and a margin of 66.61%. Chocolate is the most popular product with the largest market shares and highest margins. Other products have the lowest margin. There 15 unique product names. The top margin products or products with a margin of 60% are Everlasting Gobstopper of 80%, Hair Toffee of 78%, 5 Wonka Bar with 71%, 69%, 67%, 65%, 65% respectively, and Laffy Taffy of 62%. All the chocolate products are high margin products, taking a large share of the orders and 3 sugar products only a fraction of the total orders.
  
![product_analysis](https://github.com/user-attachments/assets/a0ae68a5-aafa-49a0-a43c-cf3b65277842)
![divisoin_sale](https://github.com/user-attachments/assets/d0639310-e834-4c26-8c31-0ed71797c611)

</p>

<p><b>Regional Sales</b>. Pacific regions have the highest share of 32.74% followed by Atlantic region of 28.26%, interior of 22.98%, and gulf of 16.02%. The margin for all regions is on the same level between 65 and 67%.
Sales target. 

  ![regional_sales](https://github.com/user-attachments/assets/a413ce6c-34cf-49dd-be38-c4e6c667f5f9)
</p>

<p>
  For the sale 2024 target by division, chocolate exceled by 57%, other exceled by 10.82%. Sugar missed by 99%. Once again, chocolate performed the best exceling expectations. 

  ![2024target](https://github.com/user-attachments/assets/851eb924-7e41-43b8-93eb-dd600343b531)


</p>
<h2>Recommandations</h2>
<p>Chocolate are the high margin products. Also, it’s the most popular products. The company should promote and push for those products into the states. Sugar products, all in all, has the lowest margin and the least market share. Perhaps, the company can eliminate sugar products due to the inefficiencies. </p>

<h2>Tableau Dashboard</h2>
<p>Here is the dashboard <a href="https://public.tableau.com/app/profile/kun.bi/viz/candy_project_1/Business_Metrics">Part 1</a> and <a href="https://public.tableau.com/app/profile/kun.bi/viz/candy_project_2/TopRegions">Part 2</a></p>


![candy_p1](https://github.com/user-attachments/assets/b49836f5-c606-4e82-b3d9-d3037383d37a)![candy_p2](https://github.com/user-attachments/assets/0a204e8d-3a9e-45a7-ac9e-9163ac512130)





