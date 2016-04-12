#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class LzServiceSvc_qryBranchPType;
@class LzServiceSvc_qryBranchPTypeResponse;
@class LzServiceSvc_photoUpload;
@class LzServiceSvc_photoUploadResponse;
@class LzServiceSvc_memberRegister;
@class LzServiceSvc_memberRegisterResponse;
@class LzServiceSvc_qryPFormat;
@class LzServiceSvc_qryPFormatResponse;
@class LzServiceSvc_qryMemberInfo;
@class LzServiceSvc_qryMemberInfoResponse;
@class LzServiceSvc_qryParentPType;
@class LzServiceSvc_qryParentPTypeResponse;
@class LzServiceSvc_qryBranchExtraType;
@class LzServiceSvc_qryBranchExtraTypeResponse;
@interface LzServiceSvc_qryBranchPType : NSObject {
	
/* elements */
	NSString * ParentID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LzServiceSvc_qryBranchPType *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * ParentID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LzServiceSvc_qryBranchPTypeResponse : NSObject {
	
/* elements */
	NSString * resultMsg;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LzServiceSvc_qryBranchPTypeResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * resultMsg;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LzServiceSvc_photoUpload : NSObject {
	
/* elements */
	NSString * strXML;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LzServiceSvc_photoUpload *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * strXML;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LzServiceSvc_photoUploadResponse : NSObject {
	
/* elements */
	NSString * resultMsg;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LzServiceSvc_photoUploadResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * resultMsg;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LzServiceSvc_memberRegister : NSObject {
	
/* elements */
	NSString * strXML;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LzServiceSvc_memberRegister *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * strXML;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LzServiceSvc_memberRegisterResponse : NSObject {
	
/* elements */
	NSString * resultMsg;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LzServiceSvc_memberRegisterResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * resultMsg;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LzServiceSvc_qryPFormat : NSObject {
	
/* elements */
	NSString * TypeID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LzServiceSvc_qryPFormat *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * TypeID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LzServiceSvc_qryPFormatResponse : NSObject {
	
/* elements */
	NSString * resultMsg;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LzServiceSvc_qryPFormatResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * resultMsg;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LzServiceSvc_qryMemberInfo : NSObject {
	
/* elements */
	NSString * strCid;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LzServiceSvc_qryMemberInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * strCid;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LzServiceSvc_qryMemberInfoResponse : NSObject {
	
/* elements */
	NSString * resultMsg;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LzServiceSvc_qryMemberInfoResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * resultMsg;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LzServiceSvc_qryParentPType : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LzServiceSvc_qryParentPType *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LzServiceSvc_qryParentPTypeResponse : NSObject {
	
/* elements */
	NSString * resultMsg;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LzServiceSvc_qryParentPTypeResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * resultMsg;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LzServiceSvc_qryBranchExtraType : NSObject {
	
/* elements */
	NSString * TypeID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LzServiceSvc_qryBranchExtraType *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * TypeID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LzServiceSvc_qryBranchExtraTypeResponse : NSObject {
	
/* elements */
	NSString * resultMsg;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LzServiceSvc_qryBranchExtraTypeResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * resultMsg;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "LzServiceSvc.h"
@class LzServiceHttpBinding;
@interface LzServiceSvc : NSObject {
	
}
+ (LzServiceHttpBinding *)LzServiceHttpBinding;
@end
@class LzServiceHttpBindingResponse;
@class LzServiceHttpBindingOperation;
@protocol LzServiceHttpBindingResponseDelegate <NSObject>
- (void) operation:(LzServiceHttpBindingOperation *)operation completedWithResponse:(LzServiceHttpBindingResponse *)response;
@end
@interface LzServiceHttpBinding : NSObject <LzServiceHttpBindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(LzServiceHttpBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (LzServiceHttpBindingResponse *)qryBranchPTypeUsingParameters:(LzServiceSvc_qryBranchPType *)aParameters ;
- (void)qryBranchPTypeAsyncUsingParameters:(LzServiceSvc_qryBranchPType *)aParameters  delegate:(id<LzServiceHttpBindingResponseDelegate>)responseDelegate;
- (LzServiceHttpBindingResponse *)photoUploadUsingParameters:(LzServiceSvc_photoUpload *)aParameters ;
- (void)photoUploadAsyncUsingParameters:(LzServiceSvc_photoUpload *)aParameters  delegate:(id<LzServiceHttpBindingResponseDelegate>)responseDelegate;
- (LzServiceHttpBindingResponse *)memberRegisterUsingParameters:(LzServiceSvc_memberRegister *)aParameters ;
- (void)memberRegisterAsyncUsingParameters:(LzServiceSvc_memberRegister *)aParameters  delegate:(id<LzServiceHttpBindingResponseDelegate>)responseDelegate;
- (LzServiceHttpBindingResponse *)qryPFormatUsingParameters:(LzServiceSvc_qryPFormat *)aParameters ;
- (void)qryPFormatAsyncUsingParameters:(LzServiceSvc_qryPFormat *)aParameters  delegate:(id<LzServiceHttpBindingResponseDelegate>)responseDelegate;
- (LzServiceHttpBindingResponse *)qryMemberInfoUsingParameters:(LzServiceSvc_qryMemberInfo *)aParameters ;
- (void)qryMemberInfoAsyncUsingParameters:(LzServiceSvc_qryMemberInfo *)aParameters  delegate:(id<LzServiceHttpBindingResponseDelegate>)responseDelegate;
- (LzServiceHttpBindingResponse *)qryParentPTypeUsingParameters:(LzServiceSvc_qryParentPType *)aParameters ;
- (void)qryParentPTypeAsyncUsingParameters:(LzServiceSvc_qryParentPType *)aParameters  delegate:(id<LzServiceHttpBindingResponseDelegate>)responseDelegate;
- (LzServiceHttpBindingResponse *)qryBranchExtraTypeUsingParameters:(LzServiceSvc_qryBranchExtraType *)aParameters ;
- (void)qryBranchExtraTypeAsyncUsingParameters:(LzServiceSvc_qryBranchExtraType *)aParameters  delegate:(id<LzServiceHttpBindingResponseDelegate>)responseDelegate;
@end
@interface LzServiceHttpBindingOperation : NSOperation {
	LzServiceHttpBinding *binding;
	LzServiceHttpBindingResponse *response;
	id<LzServiceHttpBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) LzServiceHttpBinding *binding;
@property (readonly) LzServiceHttpBindingResponse *response;
@property (nonatomic, assign) id<LzServiceHttpBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(LzServiceHttpBinding *)aBinding delegate:(id<LzServiceHttpBindingResponseDelegate>)aDelegate;
@end
@interface LzServiceHttpBinding_qryBranchPType : LzServiceHttpBindingOperation {
	LzServiceSvc_qryBranchPType * parameters;
}
@property (retain) LzServiceSvc_qryBranchPType * parameters;
- (id)initWithBinding:(LzServiceHttpBinding *)aBinding delegate:(id<LzServiceHttpBindingResponseDelegate>)aDelegate
	parameters:(LzServiceSvc_qryBranchPType *)aParameters
;
@end
@interface LzServiceHttpBinding_photoUpload : LzServiceHttpBindingOperation {
	LzServiceSvc_photoUpload * parameters;
}
@property (retain) LzServiceSvc_photoUpload * parameters;
- (id)initWithBinding:(LzServiceHttpBinding *)aBinding delegate:(id<LzServiceHttpBindingResponseDelegate>)aDelegate
	parameters:(LzServiceSvc_photoUpload *)aParameters
;
@end
@interface LzServiceHttpBinding_memberRegister : LzServiceHttpBindingOperation {
	LzServiceSvc_memberRegister * parameters;
}
@property (retain) LzServiceSvc_memberRegister * parameters;
- (id)initWithBinding:(LzServiceHttpBinding *)aBinding delegate:(id<LzServiceHttpBindingResponseDelegate>)aDelegate
	parameters:(LzServiceSvc_memberRegister *)aParameters
;
@end
@interface LzServiceHttpBinding_qryPFormat : LzServiceHttpBindingOperation {
	LzServiceSvc_qryPFormat * parameters;
}
@property (retain) LzServiceSvc_qryPFormat * parameters;
- (id)initWithBinding:(LzServiceHttpBinding *)aBinding delegate:(id<LzServiceHttpBindingResponseDelegate>)aDelegate
	parameters:(LzServiceSvc_qryPFormat *)aParameters
;
@end
@interface LzServiceHttpBinding_qryMemberInfo : LzServiceHttpBindingOperation {
	LzServiceSvc_qryMemberInfo * parameters;
}
@property (retain) LzServiceSvc_qryMemberInfo * parameters;
- (id)initWithBinding:(LzServiceHttpBinding *)aBinding delegate:(id<LzServiceHttpBindingResponseDelegate>)aDelegate
	parameters:(LzServiceSvc_qryMemberInfo *)aParameters
;
@end
@interface LzServiceHttpBinding_qryParentPType : LzServiceHttpBindingOperation {
	LzServiceSvc_qryParentPType * parameters;
}
@property (retain) LzServiceSvc_qryParentPType * parameters;
- (id)initWithBinding:(LzServiceHttpBinding *)aBinding delegate:(id<LzServiceHttpBindingResponseDelegate>)aDelegate
	parameters:(LzServiceSvc_qryParentPType *)aParameters
;
@end
@interface LzServiceHttpBinding_qryBranchExtraType : LzServiceHttpBindingOperation {
	LzServiceSvc_qryBranchExtraType * parameters;
}
@property (retain) LzServiceSvc_qryBranchExtraType * parameters;
- (id)initWithBinding:(LzServiceHttpBinding *)aBinding delegate:(id<LzServiceHttpBindingResponseDelegate>)aDelegate
	parameters:(LzServiceSvc_qryBranchExtraType *)aParameters
;
@end
@interface LzServiceHttpBinding_envelope : NSObject {
}
+ (LzServiceHttpBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface LzServiceHttpBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
