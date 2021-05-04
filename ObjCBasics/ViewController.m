//
//  ViewController.m
//  ObjCBasics
//
//  Created by Peyton Shetler on 5/3/21.
//

#import "ViewController.h"
#import "Course.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<Course *> *courses;

@end

@implementation ViewController

NSString *cellId = @"cellId";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavBar];
    [self configureTableView];
    [self fetchCourses];
}


- (void)configureNavBar {
    self.navigationItem.title = @"Courses";
    self.navigationController.navigationBar.prefersLargeTitles = YES; // can use "true" or "YES"
}


- (void)configureTableView {
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellId];
    self.tableView.tableFooterView = UIView.new;
}


- (void)fetchCourses {
    NSLog(@"This is how you print to the console in Obj-C");
    
    NSString *urlString = @"https://api.letsbuildthatapp.com/jsondecodable/courses";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
        NSError *err;
        NSArray *courseJSON = [NSJSONSerialization JSONObjectWithData:data
                                        options:NSJSONReadingAllowFragments
                                          error:&err];
        
        if (err) {
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }
        
        NSMutableArray<Course *> *courses = NSMutableArray.new;
        
        for (NSDictionary *courseDict in courseJSON) {
            Course *course = Course.new;
            course.name = courseDict[@"name"];
            course.numberOfLessons = courseDict[@"numberOfLessons"];
            
            [courses addObject:course];
        }
        
        self.courses = courses;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
            
    }] resume];
}


// Return value for function
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Generic tableview cell
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    // Hacky way to get a cell with a subtitle
    UITableViewCell *cell = [[UITableViewCell alloc]
                             initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    
    Course *course = self.courses[indexPath.row];
    
    NSString *subtitle = [NSString stringWithFormat: @"Number of Lessions: %@", course.numberOfLessons.stringValue];
    cell.textLabel.text = course.name;
    cell.detailTextLabel.text = subtitle;
    
    return cell;
}


@end
