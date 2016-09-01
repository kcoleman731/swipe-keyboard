# Sample Payloads

## Product List Message

### Payload 

```
{
  "parts":[
    {
      "mime_type":"application/json+listobject",
      "body":"{
        "status": 200,
        "data":{
          "cardType":"BTS_ITEMS",
          "btsItems":{
            "headerTitle":"School supplies list (4 items)",
            "listItems":[]
          }
        },
        "message": "OK"
      }"
    },{
      "mime_type":
      "application/json+listobject",
      "body":"{
        "status": 200,
        "data":{
          "cardType":"BTS_ITEMS",
          "listItems":[
            {
              "quantity":"1",
              "productImage":"http://www.staples-3p.com/s7/is/image/Staples/s0071040_sc7",
              "skuNo":"228445",
              "price":{
                "unitOfMeasure":"Dozen",
                "price":"16.29",
                "finalPrice":"16.29",
                "displayWasPricing":"false",
                "displayRegularPricing":"false",
                "buyMoreSaveMoreImage":""
              },
              "productName":"Paper Mate&amp;reg; FlairÂ® Felt-Tip Pens, Medium Point, Red, Dozen"
            },
            {...}
          ]
        },
        "message": "OK"
      }"
    }
  }
}
```

## Action Message

### Payload

## Shipment Tracking Message

### Payload

```
{
  "mime_type": "application/json+shipmentTrackingobject",
  "body": "{
    status: 200,
    data:{
      cardType:SHIPMENT_TRACKING_ITEMS,
      listItems:[],
      shippmentTrackingList:[
        {
          status:Processing,
          deliveryDate:Tue Aug 23 08:47:39 EDT 2016,
          shipmentNumber:201611240636027563000,
          boxes:1,
          shipmentType:STA,
          orderNumber:9700877935
        },{
          status:Processing,
          deliveryDate:Tue Aug 23 08:47:39 EDT 2016,
          shipmentNumber:201611240636027563000,
          boxes:1,
          shipmentType:STA,
          orderNumber:9700877935
        },{
          status:Processing,
          deliveryDate:Tue Aug 23 08:47:39 EDT 2016,
          shipmentNumber:201611240636027563000,
          boxes:1,
          shipmentType:STA,
          orderNumber:9700877935
        }
      ]
    },
     message: OK
  }"
}
```

## Reward Message

```
application/json+rewardobject
```
