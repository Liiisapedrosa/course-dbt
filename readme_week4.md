# Part 1: snapshot

The products that had inventory change are:
* Pothos inventory from 0 to 20
* Philondendron inventory from 15 to 30
* Bamboo inventory from 44 to 23
* ZZ Plant inventory from 53 to 41
* Monstera inventory from 50 to 31
* String of Pearls inventory from 0 to 10

Yes, we can see that the products Pothos and String of Pearls had a big fluctuation, reaching zero inventory and then back to the previous amount.

# Part 2: modelling challenge

On 2021-01-11, the total sessions with each step were:
* page views: 401
* add to cart: 290
* checkout: 184

The conversion from 'page view' to 'add to cart' is 72% and from 'add to cart' to checkout is 63%, so the biggest drop off happens between 'add to cart' and 'checkout'. 

# Part 3: next steps

My organisation is currently using dbt and if I were to make suggestions on how to improve the implementation of dbt I would first suggest to increase the testing, since as an analyst I end up doing most testing directly on Looker and I think we could leverage dbt for that. The second thing would be to improve the final layers to have more of the business logic, since a lot of it lives on LookML, which is less efficient in terms of performance and governance.