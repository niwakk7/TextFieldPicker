//
//  ViewController.m
//  TextFieldPcker
//
//  Created by 丹羽 幸生 on 2014/09/07.
//  Copyright (c) 2014年 My Company. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, retain)   UITextField *textField;
@property (nonatomic, retain)   UIPickerView *pickerView;
@property (nonatomic, retain)   UIView *backView;
@property (nonatomic, strong)   NSArray *items;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    self.items = @[@"A",@"B", @"C",@"D",];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 100, 200, 30)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.textColor = [UIColor blueColor];
    self.textField.placeholder = @"";
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    _pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    
    self.textField.inputView = self.pickerView;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    [toolBar sizeToFit];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                               target:nil action:nil];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(donePushed)];
    
    NSArray *items = [NSArray arrayWithObjects:spacer, done, nil];
    [toolBar setItems:items animated:YES];
    
    self.textField.inputAccessoryView = toolBar;
    
    _backView = [[UIView alloc] initWithFrame:self.view.frame];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = 0.2;
    self.backView.hidden = YES;
    self.backView.userInteractionEnabled = NO;
    [self.view addSubview:self.backView];
}

- (void)donePushed
{
    self.backView.hidden = YES;
    [self.textField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.backView.hidden = NO;
    
    return YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.items count];
}

- (NSString *)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.items[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.textField.text = [self.items objectAtIndex:row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
