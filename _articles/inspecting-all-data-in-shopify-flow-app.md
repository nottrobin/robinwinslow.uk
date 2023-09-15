---
cross_posts:
  DEV: https://dev.to/nottrobin/inspecting-the-order-data-available-to-shopifys-flow-app-41f9
  Hacker News: https://news.ycombinator.com/item?id=37522842
date: 2023-09-15
description: A Flow email template for inspecting all Shopify data available for a
  given order
email_campaign_id: b6f8d559b3
title: Inspecting the order data available to Shopify's Flow app
---

This is quite specific, so I don't know if it will be useful to anyone. But I really have to blog about it in a vain attempt to justify the amount of time I've spent on this.

I'm helping out a friend with [his Shopify store for buying fancy prescription sports glasses](https://v2osports.com/). He wants to automatically send an email to his suppliers whenever an order is submitted, containing all the relevant information for them to fulfill the order.

The solution he's found for this uses the free [Shopify Flow app](https://apps.shopify.com/flow). This app lets you set up workflows to do things in response to events - in this case, "Send internal email" in response to "Order created". But I'm sure it's generally useful for much more use cases I don't know of.

The template for the email is written in Flow's custom editor, and uses Liquid. So you can use `liquid` to add any of the `shop`, `order` or `order.lineItem` data to the email. However, it's pretty confusing to try to build up a mental picture of all the fields that are available to you and what they might contain for any given order. There is a handy browser which will tell you all the available variables, but it's a little slow and cumbersome to click around, and it's not easy to copy/paste names out of it.

I'm sure anyone who is trying to do this same thing would have the same challenge of experimenting and experimenting with different data, tweaking for hours and then going through the slow process of submitting test orders over and over again.

So it is incredibly helpful to have an example representation of what all the available Liquid variable contain. I had initially assumed that this would be as simple as doing something like:

```
<!-- If only this worked -->
<pre><code>
{{ shop | json }}
{{ order | json }}
</code></pre>
```

And submitting an order to get an email with a full representation of the information structure for an order. Unfortunately this doesn't work because these are in fact complex objects that make expensive API calls in the back-end in response to getters.

Helpfully, this is explained in detail [in the Shopify Flow documentation](https://help.shopify.com/en/manual/shopify-flow/reference/variables#complex-data-objects-in-shopify-flow), even though this took me a while to find:

> #### Caution
>
> You can't output a list/array or object in Liquid by calling the list or object directly, such as entering `{{ order.lineItems }}`. This limit is put in place because GraphQL can return excessive amounts of data, which would cause your workflow to fail. In addition, when new fields are introduced, it could break some workflows.
>
> Instead of calling lists and objects directly, you should loop over list and include only the fields that you want.

Instead, if you want to list out all the data you have to manually write out each of the properties you want, which is a huge amount of work.

Helpfully, the documentation provides the code to list out all the `order.lineItems` content in JSON. However, it doesn't do the same for `order` or `shop` objects.

So I've just spent a good while writing out an email tempalte for Shopify Flow that will list out much of the interesting information from the `shop` and `order` objects, along with all the `lineItems` data.

As always with all of my personal code, feel free to copy it and use it however you wish:

``` liquid
<h4>Shop</h4>

<pre><code>
{
    "billingAddress": {
        "address1": {{ shop.billingAddress.address1 | json }},
        "address2": {{ shop.billingAddress.address2 | json }},
        "city": {{ shop.billingAddress.city | json }},
        "company": {{ shop.billingAddress.company | json }},
        "coordinatesValidated": {{ shop.billingAddress.coordinatesValidated | json }},
        "country": {{ shop.billingAddress.country | json }},
        "countryCodeV2": {{ shop.billingAddress.countryCodeV2 | json }},
        "formatted": {{ shop.billingAddress.formatted | json }},
        "formattedArea": {{ shop.billingAddress.formattedArea | json }},
        "id": {{ shop.billingAddress.id | json }},
        "latitude": {{ shop.billingAddress.latitude | json }},
        "longitude": {{ shop.billingAddress.longitude | json }},
        "phone": {{ shop.billingAddress.phone | json }},
        "province": {{ shop.billingAddress.province | json }},
        "provinceCode": {{ shop.billingAddress.provinceCode | json }},
        "zip": {{ shop.billingAddress.zip | json }}
    },
    "contactEmail": {{ shop.contactEmail | json }},
    "currencyCode": {{ shop.currencyCode | json }},
    "description": {{ shop.description | json }},
    "email": {{ shop.email | json }},
    "id": {{ shop.id | json }},
    "metafields": [
        {% for field in shop.metafields %}
            {%- if field.key == "api_secret" %}{% continue %}{% endif %}
            {%- if forloop.first != true %},{% endif %}
        {
            "namespace": {{ field.namespace | json }},
            "key": {{ field.key | json }},
            "value": {{ field.value | json }},
            "description": {{ field.description | json }},
        }
        {% endfor %}
    ],
    "myshopifyDomain": {{ shop.myshopifyDomain | json }},
    "name": {{ shop.name | json }},
    "productTypes": {{ shop.productTypes | json }},
    "productVendors": {{ shop.productVendors | json }},
    "publicationCount": {{ shop.publicationCount | json }},
    "setupRequired": {{ shop.setupRequired | json }},
    "shipsToCountries": {{ shop.shipsToCountries | json }},
    "taxShipping": {{ shop.taxShipping | json }},
    "taxesIncluded": {{ shop.taxesIncluded | json }},
    "timezoneAbbreviation": {{ shop.timezoneAbbreviation | json }},
    "timezoneOffset": {{ shop.timezoneOffset | json }},
    "timezoneOffsetMinutes": {{ shop.timezoneOffsetMinutes | json }},
    "transactionalSmsDisabled": {{ shop.transactionalSmsDisabled | json }},
    "unitSystem": {{ shop.unitSystem | json }},
    "url": {{ shop.url | json }},
    "weightUnit": {{ shop.weightUnit | json }},
}
</code></pre>

<h4>Order</h4>

<pre><code>
{
    "billingAddress": {
        "address1": {{ order.billingAddress.address1 | json }},
        "address2": {{ order.billingAddress.address2 | json }},
        "city": {{ order.billingAddress.city | json }},
        "company": {{ order.billingAddress.company | json }},
        "coordinatesValidated": {{ order.billingAddress.coordinatesValidated | json }},
        "country": {{ order.billingAddress.country | json }},
        "countryCodeV2": {{ order.billingAddress.countryCodeV2 | json }},
        "firstName": {{ order.billingAddress.firstName | json }},
        "formatted": {{ order.billingAddress.formatted | json }},
        "formattedArea": {{ order.billingAddress.formattedArea | json }},
        "id": {{ order.billingAddress.id | json }},
        "lastName": {{ order.billingAddress.lastName | json }},
        "latitude": {{ order.billingAddress.latitude | json }},
        "longitude": {{ order.billingAddress.longitude | json }},
        "name": {{ order.billingAddress.name | json }},
        "phone": {{ order.billingAddress.phone | json }},
        "province": {{ order.billingAddress.province | json }},
        "provinceCode": {{ order.billingAddress.provinceCode | json }},
        "timeZone": {{ order.billingAddress.timeZone | json }},
        "zip": {{ order.billingAddress.zip | json }}
    },
    "billingAddressMatchesShippingAddress": {{ order.billingAddressMatchesShippingAddress | json }},
    "canMarkAsPaid": {{ order.canMarkAsPaid | json }},
    "canNotifyCustomer": {{ order.canNotifyCustomer | json }},
    "cancelReason": {{ order.cancelReason | json }},
    "cancelledAt": {{ order.cancelledAt | json }},
    "capturable": {{ order.capturable | json }},
    "clientIp": {{ order.clientIp | json }},
    "closed": {{ order.closed | json }},
    "closedAt": {{ order.closedAt | json }},
    "confirmationNumber": {{ order.confirmationNumber | json }},
    "confirmed": {{ order.confirmed | json }},
    "createdAt": {{ order.createdAt | json }},
    "currencyCode": {{ order.currencyCode | json }},
    "currentSubtotalLineItemsQuantity": {{ order.currentSubtotalLineItemsQuantity | json }},
    "currentTotalWeight": {{ order.currentTotalWeight | json }},
    "customerAcceptsMarketing": {{ order.customerAcceptsMarketing | json }},
    "customerLocale": {{ order.customerLocale | json }},
    "discountCode": {{ order.discountCode | json }},
    "discountCodes": {{ order.discountCodes | json }},
    "displayAddress": {
        "address1": {{ order.displayAddress.address1 | json }},
        "address2": {{ order.displayAddress.address2 | json }},
        "city": {{ order.displayAddress.city | json }},
        "company": {{ order.displayAddress.company | json }},
        "coordinatesValidated": {{ order.displayAddress.coordinatesValidated | json }},
        "country": {{ order.displayAddress.country | json }},
        "countryCodeV2": {{ order.displayAddress.countryCodeV2 | json }},
        "firstName": {{ order.displayAddress.firstName | json }},
        "formatted": {{ order.displayAddress.formatted | json }},
        "formattedArea": {{ order.displayAddress.formattedArea | json }},
        "id": {{ order.displayAddress.id | json }},
        "lastName": {{ order.displayAddress.lastName | json }},
        "latitude": {{ order.displayAddress.latitude | json }},
        "longitude": {{ order.displayAddress.longitude | json }},
        "name": {{ order.displayAddress.name | json }},
        "phone": {{ order.displayAddress.phone | json }},
        "province": {{ order.displayAddress.province | json }},
        "provinceCode": {{ order.displayAddress.provinceCode | json }},
        "timeZone": {{ order.displayAddress.timeZone | json }},
        "zip": {{ order.displayAddress.zip | json }}
    },
    "displayFinancialStatus": {{ order.displayFinancialStatus | json }},
    "displayFulfillmentStatus": {{ order.displayFulfillmentStatus | json }},
    "edited": {{ order.edited | json }},
    "email": {{ order.email | json }},
    "estimatedTaxes": {{ order.estimatedTaxes | json }},
    "fulfillable": {{ order.fulfillable | json }},
    "fullyPaid": {{ order.fullyPaid | json }},
    "hasTimelineComment": {{ order.hasTimelineComment | json }},
    "id": {{ order.id | json }},
    "legacyResourceId": {{ order.legacyResourceId | json }},
    "merchantEditable": {{ order.merchantEditable | json }},
    "merchantEditableErrors": {{ order.merchantEditableErrors | json }},
    "metafields": [
        {% for field in order.metafields %}
            {%- if forloop.first != true %},{% endif %}
        {
            "namespace": {{ field.namespace | json }},
            "key": {{ field.key | json }},
            "value": {{ field.value | json }},
            "description": {{ field.description | json }},
        }
        {% endfor %}
    ],
    "name": {{ order.name | json }},
    "note": {{ order.note | json }},
    "paymentGatewayNames": {{ order.paymentGatewayNames | json }},
    "phone": {{ order.phone | json }},
    "poNumber": {{ order.poNumber | json }},
    "presentmentCurrencyCode": {{ order.presentmentCurrencyCode | json }},
    "processedAt": {{ order.processedAt | json }},
    "refundable": {{ order.refundable | json }},
    "registeredSourceUrl": {{ order.registeredSourceUrl | json }},
    "requiresShipping": {{ order.requiresShipping | json }},
    "restockable": {{ order.restockable | json }},
    "returnStatus": {{ order.returnStatus | json }},
    "riskLevel": {{ order.riskLevel | json }},
    "sourceIdentifier": {{ order.sourceIdentifier | json }},
    "shippingAddress": {
        "address1": {{ order.shippingAddress.address1 | json }},
        "address2": {{ order.shippingAddress.address2 | json }},
        "city": {{ order.shippingAddress.city | json }},
        "company": {{ order.shippingAddress.company | json }},
        "coordinatesValidated": {{ order.shippingAddress.coordinatesValidated | json }},
        "country": {{ order.shippingAddress.country | json }},
        "countryCodeV2": {{ order.shippingAddress.countryCodeV2 | json }},
        "firstName": {{ order.shippingAddress.firstName | json }},
        "formatted": {{ order.shippingAddress.formatted | json }},
        "formattedArea": {{ order.shippingAddress.formattedArea | json }},
        "id": {{ order.shippingAddress.id | json }},
        "lastName": {{ order.shippingAddress.lastName | json }},
        "latitude": {{ order.shippingAddress.latitude | json }},
        "longitude": {{ order.shippingAddress.longitude | json }},
        "name": {{ order.shippingAddress.name | json }},
        "phone": {{ order.shippingAddress.phone | json }},
        "province": {{ order.shippingAddress.province | json }},
        "provinceCode": {{ order.shippingAddress.provinceCode | json }},
        "timeZone": {{ order.shippingAddress.timeZone | json }},
        "zip": {{ order.shippingAddress.zip | json }}
    },
    "subtotalLineItemsQuantity": {{ order.subtotalLineItemsQuantity | json }},
    "tags": {{ order.tags | json }},
    "taxExempt": {{ order.taxExempt | json }},
    "taxesIncluded": {{ order.taxesIncluded | json }},
    "test": {{ order.test | json }},
    "totalWeight": {{ order.totalWeight | json }},
    "unpaid": {{ order.unpaid | json }},
    "updatedAt": {{ order.updatedAt | json }}
}
</code></pre>

<h4>Line items</h4>

<!-- From https://help.shopify.com/en/manual/shopify-flow/reference/variables#complex-data-objects-in-shopify-flow -->

<pre><code>
{
    "lineItems": [
        {% for li in order.lineItems %}
            {% if forloop.first != true %},{% endif %}
        {
            "contract": {
                {% comment %}rest of contract omitted{% endcomment %}
                "id": {{ li.contract.id | json }}
            },
            "customAttributes": [
                {% for ca in li.customAttributes %}
                    {% if forloop.first != true %},{% endif %}
                    {
                        "key":{{ ca.key | json }},
                        "value":{{ ca.value | json }}
                    }
                {% endfor %}
            ],

            "discountAllocations": [
                {% for da in li.discountAllocations %}
                    {% if forloop.first != true %},{% endif %}
                    "allocatedAmountSet": {
                        "presentmentMoney" : {
                            "amount": {{ da.allocatedAmountSet.presentmentMoney.amount | json }},
                            "currencyCode": {{ da.allocatedAmountSet.presentmentMoney.currencyCode | json }}
                        },
                        "shopMoney": {
                            "amount": {{ da.allocatedAmountSet.shopMoney.amount | json }},
                            "currencyCode": {{ da.allocatedAmountSet.shopMoney.currencyCode | json }}
                        }
                    }
                {% endfor %}
            ],

            "discountedTotalSet": {
                "presentmentMoney" : {
                    "amount": {{ li.discountedTotalSet.presentmentMoney.amount | json }},
                    "currencyCode": {{ li.discountedTotalSet.presentmentMoney.currencyCode | json }}
                },
                "shopMoney": {
                    "amount": {{ li.discountedTotalSet.shopMoney.amount | json }},
                    "currencyCode": {{ li.discountedTotalSet.shopMoney.currencyCode | json }}
                }
            },

            "discountedUnitPriceSet": {
                "presentmentMoney" : {
                    "amount": {{ li.discountedUnitPriceSet.presentmentMoney.amount | json }},
                    "currencyCode": {{ li.discountedUnitPriceSet.presentmentMoney.currencyCode | json }}
                },
                "shopMoney": {
                    "amount": {{ li.discountedUnitPriceSet.shopMoney.amount | json }},
                    "currencyCode": {{ li.discountedUnitPriceSet.shopMoney.currencyCode | json }}
                }
            },
            "duties": [
                {% for duty in li.duties %}
                {% if forloop.first != true %},{% endif %}
                {
                    {% comment %}rest of duties omitted{% endcomment %}
                    "id": {{ duty.id | json }}
                }
                {% endfor %}
            ],
            "fulfillableQuantity": {{ li.fulfillableQuantity | json }},

            "fulfillmentService": {
                "callbackUrl":{{ li.fulfillmentService.callbackUrl | json }},
                "fulfillmentOrdersOptIn": {{ li.fulfillmentService.fulfillmentOrdersOptIn | json }},
                "handle": {{ li.fulfillmentService.handle | json }},
                "id": {{ li.fulfillmentService.id | json }},
                "inventoryManagement": {{ li.fulfillmentService.inventoryManagement | json }},
                {% comment %}fulfillmentService.inventoryManagement - omitted {% endcomment %}
                "productBased": {{ li.fulfillmentService.productBased | json }},
                "serviceName": {{ li.fulfillmentService.serviceName | json }},
                "shippingMethods": [
                    {% for sm in li.fulfillmentService.shippingMethods %}
                        {% if forloop.first != true %},{% endif %}
                        {
                            "code": {{ sm.code | json }},
                            "label": {{ sm.label | json }}
                        }
                    {% endfor %}
                ],
                "type": {{ li.fulfillmentService.type | json }}

            },
            "fulfillmentStatus": {{ li.fulfillmentStatus | json }},
            "id": {{ li.id | json }},
            "image": {
                "altText": {{ li.image.altText | json }},
                "height": {{ li.image.height | json }},
                "id": {{ li.image.id | json }},
                {% comment %}li.image.metafield omitted{% endcomment %}
                {% comment %}li.image.privateMetafield omitted{% endcomment %}
                "width":{{ li.image.width | json }}
            },
            "merchantEditable": {{ li.merchantEditable | json }},
            "name": {{ li.name | json }},
            "nonFulfillableQuantity": {{ li.nonFulfillableQuantity | json }},

            "originalTotalSet": {
                "presentmentMoney" : {
                    "amount": {{ li.originalTotalSet.presentmentMoney.amount | json }},
                    "currencyCode": {{ li.originalTotalSet.presentmentMoney.currencyCode | json }}
                },
                "shopMoney": {
                    "amount": {{ li.originalTotalSet.shopMoney.amount | json }},
                    "currencyCode": {{ li.originalTotalSet.shopMoney.currencyCode | json }}
                }
            },

            "originalUnitPriceSet": {
                "presentmentMoney" : {
                    "amount": {{ li.originalUnitPriceSet.presentmentMoney.amount | json }},
                    "currencyCode": {{ li.originalUnitPriceSet.presentmentMoney.currencyCode | json }}
                },
                "shopMoney": {
                    "amount": {{ li.originalUnitPriceSet.shopMoney.amount | json }},
                    "currencyCode": {{ li.originalUnitPriceSet.shopMoney.currencyCode | json }}
                }
            },

            "product": {
                {% comment %}rest of Product omitted{% endcomment %}
                "title": {{ li.product.title | json }}
            },

            "quantity": {{ li.quantity | json }},
            "refundableQuantity": {{ li.refundableQuantity | json }},
            "requiresShipping": {{ li.requiresShipping | json }},
            "restockable": {{ li.restockable | json }},

            "sellingPlan": {
                "name": {{ li.sellingPlan.name | json }}
            },

            "sku": {{ li.sku | json }},

            "taxLines": [
                {% for tl in li.taxLines %}
                    {% if forloop.first != true %},{% endif %}
                    {
                        "priceSet": {
                            "presentmentMoney" : {
                                "amount": {{ tl.priceSet.presentmentMoney.amount | json }},
                                "currencyCode": {{ tl.priceSet.presentmentMoney.currencyCode | json }}
                            },
                            "shopMoney": {
                                "amount": {{ tl.priceSet.shopMoney.amount | json }},
                                "currencyCode": {{ tl.priceSet.shopMoney.currencyCode | json }}
                            }
                        },
                        "rate": {{ tl.rate | json }},
                        "ratePercentage": {{ tl.ratePercentage | json }},
                        "title": {{ tl.title | json }}
                    }
                {% endfor %}
            ],
            "taxable":{{ li.taxable | json }},
            "title":{{ li.title | json }},

            "totalDiscountSet": {
                "presentmentMoney" : {
                    "amount": {{ li.totalDiscountSet.presentmentMoney.amount | json }},
                    "currencyCode": {{ li.totalDiscountSet.presentmentMoney.currencyCode | json }}
                },
                "shopMoney": {
                    "amount": {{ li.totalDiscountSet.shopMoney.amount | json }},
                    "currencyCode": {{ li.totalDiscountSet.shopMoney.currencyCode | json }}
                }
            },

            "unfulfilledDiscountedTotalSet": {
                "presentmentMoney" : {
                    "amount": {{ li.unfulfilledDiscountedTotalSet.presentmentMoney.amount | json }},
                    "currencyCode": {{ li.unfulfilledDiscountedTotalSet.presentmentMoney.currencyCode | json }}
                },
                "shopMoney": {
                    "amount": {{ li.unfulfilledDiscountedTotalSet.shopMoney.amount | json }},
                    "currencyCode": {{ li.unfulfilledDiscountedTotalSet.shopMoney.currencyCode | json }}
                }
            },

            "unfulfilledOriginalTotalSet": {
                "presentmentMoney" : {
                    "amount": {{ li.unfulfilledOriginalTotalSet.presentmentMoney.amount | json }},
                    "currencyCode": {{ li.unfulfilledOriginalTotalSet.presentmentMoney.currencyCode | json }}
                },
                "shopMoney": {
                    "amount": {{ li.unfulfilledOriginalTotalSet.shopMoney.amount | json }},
                    "currencyCode": {{ li.unfulfilledOriginalTotalSet.shopMoney.currencyCode | json }}
                }
            },

            "unfulfilledQuantity": {{ li.unfulfilledQuantity | json }},

            "variant": {
                {% comment %}rest of variant omitted {% endcomment %}
                "title": {{ li.variant.title | json }}
            },

            "variantTitle": {{ li.variantTitle | json }},
            "vendor": {{ li.vendor | json }}
        }
    {% endfor %}
    ]
}
</code></pre>
```

Or [find it on my GitHub](https://github.com/nottrobin/v20-email/blob/main/display-data.liquid).