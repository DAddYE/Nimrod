

type
  Feature = tuple[name: String, version: String]
  PDOMImplementation* = ref DOMImplementation
  DOMImplementation = object
    Features: Seq[Feature] # Read-Only

  PNode* = ref Node
  Node = object {.inheritable.}
    attributes*: Seq[PAttr]
    childNodes*: Seq[PNode]
    FLocalName: String # Read-only
    fNamespaceURI: String # Read-only
    FNodeName: String # Read-only
    nodeValue*: String
    FNodeType: Int # Read-only
    FOwnerDocument: PDocument # Read-Only
    FParentNode: PNode # Read-Only
    prefix*: String # Setting this should change some values... TODO!
  
  PElement* = ref Element
  Element = object of Node
    FTagName: String # Read-only
  
  PCharacterData = ref CharacterData
  CharacterData = object of Node
    data*: String
    
  PDocument* = ref Document
  Document = object of Node
    FImplementation: PDOMImplementation # Read-only
    FDocumentElement: PElement # Read-only
    
  PAttr* = ref Attr  
  Attr = object of Node
    FName: String # Read-only
    FSpecified: Bool # Read-only
    value*: String
    FOwnerElement: PElement # Read-only

  PDocumentFragment* = ref DocumentFragment
  DocumentFragment = object of Node

  PText* = ref Text
  Text = object of CharacterData
  
  PComment* = ref Comment
  Comment = object of CharacterData
  
  PCDataSection* = ref CDataSection
  CDataSection = object of Text
    
  PProcessingInstruction* = ref ProcessingInstruction
  ProcessingInstruction = object of Node
    data*: String
    FTarget: String # Read-only

proc `namespaceURI=`*(n: var PNode, value: String) = 
  n.FNamespaceURI = value
  
proc main = 
  var n: PNode
  new(n)
  n.namespaceURI = "test"

main()
