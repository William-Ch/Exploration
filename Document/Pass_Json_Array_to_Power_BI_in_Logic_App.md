Pass Json Array to Power BI in Logic App
================

![Logic App - Designer](https://github.com/William-Ch/Exploration/blob/master/Images/Logic%20App-Designer.PNG)

If input dataset is a json array, it needs to be transformed to flat table with a "foreach" action before send to Power BI streaming dataset or a database.

When assign "body" to fields of a Power BI streaming dataset, the javascript code will look like below by default:

``` javascript
"For_each": {
                "actions": {
                    "Add_rows_to_a_dataset": { //action name
                        "inputs": {
                            "body": { //item to pass to each field of Power BI streaming dataset
                                "address": "@{triggerBody()}",
                                "available_bike_stands": "@{triggerBody()}",
                                "available_bikes": "@{triggerBody()}",
                                "bike_stands": "@{triggerBody()}",
                                "last_update": "@{triggerBody()}",
                                "latitude": "@{triggerBody()}",
                                "longitude": "@{triggerBody()}",
                                "name": "@{triggerBody()}",
                                "number": "@{triggerBody()}",
                                "status": "@{triggerBody()}"
                            },
                            "host": {
                                "connection": {
                                    "name": "@parameters('$connections')['powerbi']['connectionId']"
                                }
                            },
                            "method": "post",
                            "path": "/v1.0/myorg/groups/@{encodeURIComponent('myworkspace')}/datasets/@{encodeURIComponent('ac624efc-c7c2-44e8-b6d8-198d4d934997')}/tables/@{encodeURIComponent('RealTimeData')}/rows"
                        },
                        "runAfter": {},
                        "type": "ApiConnection"
                    }
                },
                "foreach": "@triggerBody()", //input of the "foreach" action
                "runAfter": {},
                "type": "Foreach"
            }
```

Item passes to each field should be a single item of the foreach loop. However, the default code pass body of trigger, which is still an array, to each row. Therefore, it returns error while executing the action. This issue could be solved by editing code from "Code view" which can be swiched in the top panel.

In code view, amend item pass to each field from `@{triggerBody()}` to `@{items('For_each').<field_reference>`. The final code will look like this

``` javascript
"For_each": {
                "actions": {
                    "Add_rows_to_a_dataset": {
                        "inputs": {
                            "body": { //amend item pass to each field
                                "address": "@{items('For_each').address}",
                                "available_bike_stands": "@{items('For_each').available_bike_stands}",
                                "available_bikes": "@{items('For_each').available_bikes}",
                                "bike_stands": "@{items('For_each')['bike_stands']}",
                                "last_update": "@{items('For_each').last_update}",
                                "latitude": "@{items('For_each').position.lat}",
                                "longitude": "@{items('For_each').position.lng}",
                                "name": "@{items('For_each').name}",
                                "number": "@{items('For_each').number}",
                                "status": "@{items('For_each').status}"
                            },
                            "host": {
                                "connection": {
                                    "name": "@parameters('$connections')['powerbi']['connectionId']"
                                }
                            },
                            "method": "post",
                            "path": "/v1.0/myorg/groups/@{encodeURIComponent('myworkspace')}/datasets/@{encodeURIComponent('ac624efc-c7c2-44e8-b6d8-198d4d934997')}/tables/@{encodeURIComponent('RealTimeData')}/rows"
                        },
                        "runAfter": {},
                        "type": "ApiConnection"
                    }
                },
                "foreach": "@triggerBody()",
                "runAfter": {},
                "type": "Foreach"
            }
```
