### Access the app

Login in to the app with the credientials

test@test.com

test123

### Page Transition

The transition will be from the homeController to the searchview file. The searchIcon that will trigger this change is 
in the homeheader file. 

``` 

lazy var searchIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_selected").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(openSearchModal), for: .touchUpInside)
        return button
    }()

```

### Scroll view animation

The scroll view can be added to the pursuit day cell inside the detail folder. The goal is to make the days labels 
shift on click.

### The alamofire call listening for changes can be added to any of the services files in a seperate function.

