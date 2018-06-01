# Demo

MVVM architecture is used in the demo project. Every UIViewController has its own ViewModel. Similarly, every cell will have its own ViewModelCell. ViewModel is defined in terms of inputs and outputs. For outputs, I have used simply closures to update view/viewcontroller. 

However, I prefer to use Functional Reactive programming since I have been uisng RxSwift for quite a while. In which I define my inputs as PublishedSubject and output as Observable or Behavior Subjects. But for this demo project, I avoid using FRP since It required some other third party libraries like RxDataSources (for tableView) and RxBlocking(Unit testing) which was not the requirement as well. I used simple approach to make my own view models but underlying input/output concept is same. 

**Environment:** Contains all global and Singleton variables that app has access to. I like this way of injecting into ViewModel. It can be helpful when you have lots of dependency and you can simply inject once rather than one by one. It can also helps in mocking all dependency. 

**Unit test cases:** I have not covered 100% test cases but all the core test cases are written in MoviesListViewModelTests. 

For saving, since the requirment was to save 10 last recent sugesstion. I have used NSuserdefauly to persist suggesstions. But I prefer to use Realm for objects.  

I checked this app on  iOS 9.3 and 11.3.1

**Third party libraries**
 Alamofire'
'SDWebImage'
'ModelMapper'


