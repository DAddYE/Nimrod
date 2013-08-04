#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2010 Dominik Picheta
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#


import strutils
## This module implements XML DOM Level 2 Core specification(http://www.w3.org/TR/2000/REC-DOM-Level-2-Core-20001113/core.html)


#http://www.w3.org/TR/2000/REC-DOM-Level-2-Core-20001113/core.html

#Exceptions
type
  EDOMException* = object of EInvalidValue ## Base exception object for all DOM Exceptions
  EDOMStringSizeErr* = object of EDOMException ## If the specified range of text does not fit into a DOMString
                                               ## Currently not used(Since DOMString is just string)
  EHierarchyRequestErr* = object of EDOMException ## If any node is inserted somewhere it doesn't belong
  EIndexSizeErr* = object of EDOMException ## If index or size is negative, or greater than the allowed value
  EInuseAttributeErr* = object of EDOMException ## If an attempt is made to add an attribute that is already in use elsewhere
  EInvalidAccessErr* = object of EDOMException ## If a parameter or an operation is not supported by the underlying object.
  EInvalidCharacterErr* = object of EDOMException ## This exception is raised when a string parameter contains an illegal character
  EInvalidModificationErr* = object of EDOMException ## If an attempt is made to modify the type of the underlying object.
  EInvalidStateErr* = object of EDOMException ## If an attempt is made to use an object that is not, or is no longer, usable.
  ENamespaceErr* = object of EDOMException ## If an attempt is made to create or change an object in a way which is incorrect with regard to namespaces.
  ENotFoundErr* = object of EDOMException ## If an attempt is made to reference a node in a context where it does not exist
  ENotSupportedErr* = object of EDOMException ## If the implementation does not support the requested type of object or operation.
  ENoDataAllowedErr* = object of EDOMException ## If data is specified for a node which does not support data
  ENoModificationAllowedErr* = object of EDOMException ## If an attempt is made to modify an object where modifications are not allowed
  ESyntaxErr* = object of EDOMException ## If an invalid or illegal string is specified.
  EWrongDocumentErr* = object of EDOMException ## If a node is used in a different document than the one that created it (that doesn't support it)

const
  ElementNode* = 1
  AttributeNode* = 2
  TextNode* = 3
  CDataSectionNode* = 4
  ProcessingInstructionNode* = 7
  CommentNode* = 8
  DocumentNode* = 9
  DocumentFragmentNode* = 11

  # Nodes which are childless - Not sure about AttributeNode
  childlessObjects = {DocumentNode, AttributeNode, TextNode, 
    CDataSectionNode, ProcessingInstructionNode, CommentNode}
  # Illegal characters
  illegalChars = {'>', '<', '&', '"'}


type
  Feature = tuple[name: String, version: String]
  PDOMImplementation* = ref DOMImplementation
  DOMImplementation = object
    features: Seq[Feature] # Read-Only

  PNode* = ref Node
  Node = object of TObject
    attributes*: Seq[PAttr]
    childNodes*: Seq[PNode]
    fLocalName: String # Read-only
    fNamespaceURI: String # Read-only
    fNodeName: String # Read-only
    nodeValue*: String
    fNodeType: Int # Read-only
    fOwnerDocument: PDocument # Read-Only
    fParentNode: PNode # Read-Only
    prefix*: String # Setting this should change some values... TODO!
  
  PElement* = ref Element
  Element = object of Node
    fTagName: String # Read-only
  
  PCharacterData* = ref CharacterData
  CharacterData = object of Node
    data*: String
    
  PDocument* = ref Document
  Document = object of Node
    fImplementation: PDOMImplementation # Read-only
    fDocumentElement: PElement # Read-only
    
  PAttr* = ref Attr  
  Attr = object of Node
    fName: String # Read-only
    fSpecified: Bool # Read-only
    value*: String
    fOwnerElement: PElement # Read-only

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
    fTarget: String # Read-only

# DOMImplementation
proc getDOM*(): PDOMImplementation =
  ## Returns a DOMImplementation
  new(result)
  result.Features = @[(name: "core", version: "2.0"), 
                      (name: "core", version: "1.0"), 
                      (name: "XML", version: "2.0")]

proc createDocument*(dom: PDOMImplementation, namespaceURI: String, qualifiedName: String): PDocument =
  ## Creates an XML Document object of the specified type with its document element.
  var doc: PDocument
  new(doc)
  doc.FNamespaceURI = namespaceURI
  doc.FImplementation = dom
  
  var elTag: PElement
  new(elTag)
  elTag.FTagName = qualifiedName
  elTag.FNodeName = qualifiedName
  doc.FDocumentElement = elTag
  doc.FNodeType = DocumentNode
  
  return doc
  
proc createDocument*(dom: PDOMImplementation, n: PElement): PDocument =
  ## Creates an XML Document object of the specified type with its document element.
  
  # This procedure is not in the specification, it's provided for the parser.
  var doc: PDocument
  new(doc)
  doc.FDocumentElement = n
  doc.FImplementation = dom
  doc.FNodeType = DocumentNode
  
  return doc
  
proc hasFeature*(dom: PDOMImplementation, feature: String, version: String = ""): Bool =
  ## Returns ``true`` if this ``version`` of the DomImplementation implements ``feature``, otherwise ``false``
  for iName, iVersion in items(dom.Features):
    if iName == feature:
      if version == "":
        return true
      else:
        if iVersion == version:
          return true
  return false


# Document
# Attributes
  
proc implementation*(doc: PDocument): PDOMImplementation =
  return doc.FImplementation
  
proc documentElement*(doc: PDocument): PElement = 
  return doc.FDocumentElement

# Internal procedures
proc findNodes(nl: PNode, name: String): Seq[PNode] =
  # Made for getElementsByTagName
  var r: Seq[PNode] = @[]
  if isNil(nl.childNodes): return @[]
  if nl.childNodes.len() == 0: return @[]

  for i in items(nl.childNodes):
    if i.FNodeType == ElementNode:
      if i.FNodeName == name or name == "*":
        r.add(i)
        
      if not isNil(i.childNodes):
        if i.childNodes.len() != 0:
          r.add(findNodes(i, name))
    
  return r
  
proc findNodesNS(nl: PNode, namespaceURI: String, localName: String): Seq[PNode] =
  # Made for getElementsByTagNameNS
  var r: Seq[PNode] = @[]
  if isNil(nl.childNodes): return @[]
  if nl.childNodes.len() == 0: return @[]

  for i in items(nl.childNodes):
    if i.FNodeType == ElementNode:
      if (i.FNamespaceURI == namespaceURI or namespaceURI == "*") and (i.FLocalName == localName or localName == "*"):
        r.add(i)
        
      if not isNil(i.childNodes):
        if i.childNodes.len() != 0:
          r.add(findNodesNS(i, namespaceURI, localName))
    
  return r
    

#Procedures
proc createAttribute*(doc: PDocument, name: String): PAttr =
  ## Creates an Attr of the given name. Note that the Attr instance can then be set on an Element using the setAttributeNode method.
  ## To create an attribute with a qualified name and namespace URI, use the createAttributeNS method. 
  
  # Check if name contains illegal characters
  if illegalChars in name:
    raise newException(EInvalidCharacterErr, "Invalid character")
  
  var attrNode: PAttr
  new(attrNode)
  attrNode.FName = name
  attrNode.FNodeName = name
  attrNode.FLocalName = nil
  attrNode.prefix = nil
  attrNode.FNamespaceURI = nil
  attrNode.value = ""
  attrNode.FSpecified = false
  return attrNode

proc createAttributeNS*(doc: PDocument, namespaceURI: String, qualifiedName: String): PAttr =
  ## Creates an attribute of the given qualified name and namespace URI
  
  # Check if name contains illegal characters
  if illegalChars in namespaceURI or illegalChars in qualifiedName:
    raise newException(EInvalidCharacterErr, "Invalid character")
  # Exceptions
  if qualifiedName.contains(':'):
    if namespaceURI == nil:
      raise newException(ENamespaceErr, "When qualifiedName contains a prefix namespaceURI cannot be nil")
    elif qualifiedName.split(':')[0].toLower() == "xml" and namespaceURI != "http://www.w3.org/XML/1998/namespace":
      raise newException(ENamespaceErr, 
        "When the namespace prefix is \"xml\" namespaceURI has to be \"http://www.w3.org/XML/1998/namespace\"")
    elif qualifiedName.split(':')[1].toLower() == "xmlns" and namespaceURI != "http://www.w3.org/2000/xmlns/":
      raise newException(ENamespaceErr, 
        "When the namespace prefix is \"xmlns\" namespaceURI has to be \"http://www.w3.org/2000/xmlns/\"")
  
  var attrNode: PAttr
  new(attrNode)
  attrNode.FName = qualifiedName
  attrNode.FNodeName = qualifiedName
  attrNode.FSpecified = false
  attrNode.FNamespaceURI = namespaceURI
  if qualifiedName.contains(':'):
    attrNode.prefix = qualifiedName.split(':')[0]
    attrNode.FLocalName = qualifiedName.split(':')[1]
  else:
    attrNode.prefix = nil
    attrNode.FLocalName = qualifiedName
  attrNode.value = ""
  
  attrNode.FNodeType = AttributeNode
  return attrNode

proc createCDATASection*(doc: PDocument, data: String): PCDataSection =
  ## Creates a CDATASection node whose value is the specified string.
  var cData: PCDataSection
  new(cData)
  cData.data = data
  cData.nodeValue = data
  cData.FNodeName = "#text" # Not sure about this, but this is technically a TextNode
  cData.FNodeType = CDataSectionNode
  return cData

proc createComment*(doc: PDocument, data: String): PComment =
  ## Creates a Comment node given the specified string. 
  var comm: PComment
  new(comm)
  comm.data = data
  comm.nodeValue = data
  
  comm.FNodeType = CommentNode
  return comm

proc createDocumentFragment*(doc: PDocument): PDocumentFragment =
  ## Creates an empty DocumentFragment object.
  var df: PDocumentFragment
  new(df)
  return df

proc createElement*(doc: PDocument, tagName: String): PElement =
  ## Creates an element of the type specified.
  
  # Check if name contains illegal characters
  if illegalChars in tagName:
    raise newException(EInvalidCharacterErr, "Invalid character")
    
  var elNode: PElement
  new(elNode)
  elNode.FTagName = tagName
  elNode.FNodeName = tagName
  elNode.FLocalName = nil
  elNode.prefix = nil
  elNode.FNamespaceURI = nil
  elNode.childNodes = @[]
  elNode.attributes = @[]
  
  elNode.FNodeType = ElementNode
  
  return elNode

proc createElementNS*(doc: PDocument, namespaceURI: String, qualifiedName: String): PElement =
  ## Creates an element of the given qualified name and namespace URI.
  if qualifiedName.contains(':'):
    if namespaceURI == nil:
      raise newException(ENamespaceErr, "When qualifiedName contains a prefix namespaceURI cannot be nil")
    elif qualifiedName.split(':')[0].toLower() == "xml" and namespaceURI != "http://www.w3.org/XML/1998/namespace":
      raise newException(ENamespaceErr, 
        "When the namespace prefix is \"xml\" namespaceURI has to be \"http://www.w3.org/XML/1998/namespace\"")
        
  # Check if name contains illegal characters
  if illegalChars in namespaceURI or illegalChars in qualifiedName:
    raise newException(EInvalidCharacterErr, "Invalid character")
    
  var elNode: PElement
  new(elNode)
  elNode.FTagName = qualifiedName
  elNode.FNodeName = qualifiedName
  if qualifiedName.contains(':'):
    elNode.prefix = qualifiedName.split(':')[0]
    elNode.FLocalName = qualifiedName.split(':')[1]
  else:
    elNode.prefix = nil
    elNode.FLocalName = qualifiedName
  elNode.FNamespaceURI = namespaceURI
  elNode.childNodes = @[]
  elNode.attributes = @[]
  
  elNode.FNodeType = ElementNode
  
  return elNode

proc createProcessingInstruction*(doc: PDocument, target: String, data: String): PProcessingInstruction = 
  ## Creates a ProcessingInstruction node given the specified name and data strings. 
  
  #Check if name contains illegal characters
  if illegalChars in target:
    raise newException(EInvalidCharacterErr, "Invalid character")
    
  var pi: PProcessingInstruction
  new(pi)
  pi.FTarget = target
  pi.data = data
  pi.FNodeType = ProcessingInstructionNode
  return pi

proc createTextNode*(doc: PDocument, data: String): PText = #Propably TextNode
  ## Creates a Text node given the specified string. 
  var txtNode: PText
  new(txtNode)
  txtNode.data = data
  txtNode.nodeValue = data
  txtNode.FNodeName = "#text"
  
  txtNode.FNodeType = TextNode
  return txtNode

discard """proc getElementById*(doc: PDocument, elementId: string): PElement =
  ##Returns the ``Element`` whose ID is given by ``elementId``. If no such element exists, returns ``nil``
  #TODO"""

proc getElementsByTagName*(doc: PDocument, tagName: String): Seq[PNode] =
  ## Returns a NodeList of all the Elements with a given tag name in
  ## the order in which they are encountered in a preorder traversal of the Document tree. 
  var result: Seq[PNode] = @[]
  if doc.FDocumentElement.FNodeName == tagName or tagName == "*":
    result.add(doc.FDocumentElement)
  
  result.add(doc.FDocumentElement.findNodes(tagName))
  return result
  
proc getElementsByTagNameNS*(doc: PDocument, namespaceURI: String, localName: String): Seq[PNode] =
  ## Returns a NodeList of all the Elements with a given localName and namespaceURI
  ## in the order in which they are encountered in a preorder traversal of the Document tree. 
  var result: Seq[PNode] = @[]
  if doc.FDocumentElement.FLocalName == localName or localName == "*":
    if doc.FDocumentElement.FNamespaceURI == namespaceURI or namespaceURI == "*":
      result.add(doc.FDocumentElement)
      
  result.add(doc.FDocumentElement.findNodesNS(namespaceURI, localName))
  return result

proc importNode*(doc: PDocument, importedNode: PNode, deep: Bool): PNode =
  ## Imports a node from another document to this document
  case importedNode.FNodeType
  of AttributeNode:
    var nAttr: PAttr = PAttr(importedNode)
    nAttr.FOwnerDocument = doc
    nAttr.FParentNode = nil
    nAttr.FOwnerElement = nil
    nAttr.FSpecified = true
    return nAttr
  of DocumentFragmentNode:
    var n: PNode
    new(n)
    n = importedNode
    n.FOwnerDocument = doc
    n.FParentNode = nil

    n.FOwnerDocument = doc
    n.FParentNode = nil
    var tmp: Seq[PNode] = n.childNodes
    n.childNodes = @[]
    if deep:
      for i in low(tmp.len())..high(tmp.len()):
        n.childNodes.add(importNode(doc, tmp[i], deep))
        
    return n
  of ElementNode:
    var n: PNode
    new(n)
    n = importedNode
    n.FOwnerDocument = doc
    n.FParentNode = nil
    
    var tmpA: Seq[PAttr] = n.attributes
    n.attributes = @[]
    # Import the Element node's attributes
    for i in low(tmpA.len())..high(tmpA.len()):
      n.attributes.add(PAttr(importNode(doc, tmpA[i], deep)))
    # Import the childNodes
    var tmp: Seq[PNode] = n.childNodes
    n.childNodes = @[]
    if deep:
      for i in low(tmp.len())..high(tmp.len()):
        n.childNodes.add(importNode(doc, tmp[i], deep))
        
    return n
  of ProcessingInstructionNode, TextNode, CDataSectionNode, CommentNode:
    var n: PNode
    new(n)
    n = importedNode
    n.FOwnerDocument = doc
    n.FParentNode = nil
    return n
  else:
    raise newException(ENotSupportedErr, "The type of node being imported is not supported")
  

# Node
# Attributes
  
proc firstChild*(n: PNode): PNode =
  ## Returns this node's first child

  if n.childNodes.len() > 0:
    return n.childNodes[0]
  else:
    return nil
  
proc lastChild*(n: PNode): PNode =
  ## Returns this node's last child

  if n.childNodes.len() > 0:
    return n.childNodes[n.childNodes.len() - 1]
  else:
    return nil
  
proc localName*(n: PNode): String =
  ## Returns this nodes local name

  return n.FLocalName

proc namespaceURI*(n: PNode): String =
  ## Returns this nodes namespace URI
  
  return n.FNamespaceURI
  
proc `namespaceURI=`*(n: PNode, value: String) = 
  n.FNamespaceURI = value

proc nextSibling*(n: PNode): PNode =
  ## Returns the next sibling of this node

  var nLow: Int = low(n.FParentNode.childNodes)
  var nHigh: Int = high(n.FParentNode.childNodes)
  for i in nLow..nHigh:
    if n.FParentNode.childNodes[i] == n:
      return n.FParentNode.childNodes[i + 1]
  return nil

proc nodeName*(n: PNode): String =
  ## Returns the name of this node

  return n.FNodeName

proc nodeType*(n: PNode): Int =
  ## Returns the type of this node

  return n.FNodeType

proc ownerDocument*(n: PNode): PDocument =
  ## Returns the owner document of this node

  return n.FOwnerDocument

proc parentNode*(n: PNode): PNode =
  ## Returns the parent node of this node

  return n.FParentNode
  
proc previousSibling*(n: PNode): PNode =
  ## Returns the previous sibling of this node

  var nLow: Int = low(n.FParentNode.childNodes)
  var nHigh: Int = high(n.FParentNode.childNodes)
  for i in nLow..nHigh:
    if n.FParentNode.childNodes[i] == n:
      return n.FParentNode.childNodes[i - 1]
  return nil
  
proc `prefix=`*(n: PNode, value: String) =
  ## Modifies the prefix of this node

  # Setter
  # Check if name contains illegal characters
  if illegalChars in value:
    raise newException(EInvalidCharacterErr, "Invalid character")

  if n.FNamespaceURI == nil:
    raise newException(ENamespaceErr, "namespaceURI cannot be nil")
  elif value.toLower() == "xml" and n.FNamespaceURI != "http://www.w3.org/XML/1998/namespace":
    raise newException(ENamespaceErr, 
      "When the namespace prefix is \"xml\" namespaceURI has to be \"http://www.w3.org/XML/1998/namespace\"")
  elif value.toLower() == "xmlns" and n.FNamespaceURI != "http://www.w3.org/2000/xmlns/":
    raise newException(ENamespaceErr, 
      "When the namespace prefix is \"xmlns\" namespaceURI has to be \"http://www.w3.org/2000/xmlns/\"")
  elif value.toLower() == "xmlns" and n.FNodeType == AttributeNode:
    raise newException(ENamespaceErr, "An AttributeNode cannot have a prefix of \"xmlns\"")

  n.FNodeName = value & ":" & n.FLocalName
  if n.nodeType == ElementNode:
    var el: PElement = PElement(n)
    el.FTagName = value & ":" & n.FLocalName

  elif n.nodeType == AttributeNode:
    var attr: PAttr = PAttr(n)
    attr.FName = value & ":" & n.FLocalName

# Procedures
proc appendChild*(n: PNode, newChild: PNode) =
  ## Adds the node newChild to the end of the list of children of this node.
  ## If the newChild is already in the tree, it is first removed.
  
  # Check if n contains newChild
  if not isNil(n.childNodes):
    for i in low(n.childNodes)..high(n.childNodes):
      if n.childNodes[i] == newChild:
        raise newException(EHierarchyRequestErr, "The node to append is already in this nodes children.")
  
  # Check if newChild is from this nodes document
  if n.FOwnerDocument != newChild.FOwnerDocument:
    raise newException(EWrongDocumentErr, "This node belongs to a different document, use importNode.")
  
  if n == newChild:
    raise newException(EHierarchyRequestErr, "You can't add a node into itself")
  
  if n.nodeType in childlessObjects:
    raise newException(ENoModificationAllowedErr, "Cannot append children to a childless node")
  
  if isNil(n.childNodes): n.childNodes = @[]
    
  newChild.FParentNode = n
  for i in low(n.childNodes)..high(n.childNodes):
    if n.childNodes[i] == newChild:
      n.childNodes[i] = newChild
    
  n.childNodes.add(newChild)

proc cloneNode*(n: PNode, deep: Bool): PNode = 
  ## Returns a duplicate of this node, if ``deep`` is `true`, Element node's children are copied
  case n.FNodeType
  of AttributeNode:
    var newNode: PAttr
    new(newNode)
    newNode = PAttr(n)
    newNode.FSpecified = true
    newNode.FOwnerElement = nil
    return newNode
  of ElementNode:
    var newNode: PElement
    new(newNode)
    newNode = PElement(n)
    # Import the childNodes
    var tmp: Seq[PNode] = n.childNodes
    n.childNodes = @[]
    if deep:
      for i in low(tmp.len())..high(tmp.len()):
        n.childNodes.add(cloneNode(tmp[i], deep))
    return newNode
  else:
    var newNode: PNode
    new(newNode)
    newNode = n
    return newNode

proc hasAttributes*(n: PNode): Bool =
  ## Returns whether this node (if it is an element) has any attributes. 
  return n.attributes.len() > 0

proc hasChildNodes*(n: PNode): Bool = 
  ## Returns whether this node has any children.
  return n.childNodes.len() > 0

proc insertBefore*(n: PNode, newChild: PNode, refChild: PNode): PNode =
  ## Inserts the node ``newChild`` before the existing child node ``refChild``.
  ## If ``refChild`` is nil, insert ``newChild`` at the end of the list of children.
  
  # Check if newChild is from this nodes document
  if n.FOwnerDocument != newChild.FOwnerDocument:
    raise newException(EWrongDocumentErr, "This node belongs to a different document, use importNode.")
    
  for i in low(n.childNodes)..high(n.childNodes):
    if n.childNodes[i] == refChild:
      n.childNodes.insert(newChild, i - 1)
    return

proc isSupported*(n: PNode, feature: String, version: String): Bool =
  ## Tests whether the DOM implementation implements a specific 
  ## feature and that feature is supported by this node. 
  return n.FOwnerDocument.FImplementation.hasFeature(feature, version)

proc isEmpty(s: String): Bool =

  if s == "" or s == nil:
    return true
  for i in items(s):
    if i != ' ':
      return false
  return true

proc normalize*(n: PNode) =
  ## Merges all seperated TextNodes together, and removes any empty TextNodes
  var curTextNode: PNode = nil
  var i: Int = 0
  
  var newChildNodes: Seq[PNode] = @[]
  while true:
    if i >= n.childNodes.len:
      break
    if n.childNodes[i].nodeType == TextNode:
      
      #If the TextNode is empty, remove it
      if PText(n.childNodes[i]).data.isEmpty():
        inc(i)
      
      if curTextNode == nil:
        curTextNode = n.childNodes[i]
      else:
        PText(curTextNode).data.add(PText(n.childNodes[i]).data)
        curTextNode.nodeValue.add(PText(n.childNodes[i]).data)
        inc(i)
    else:
      newChildNodes.add(curTextNode)
      newChildNodes.add(n.childNodes[i])
      curTextNode = nil
    
    inc(i)
  n.childNodes = newChildNodes

proc removeChild*(n: PNode, oldChild: PNode): PNode =
  ## Removes the child node indicated by ``oldChild`` from the list of children, and returns it.
  for i in low(n.childNodes)..high(n.childNodes):
    if n.childNodes[i] == oldChild:
      result = n.childNodes[i]
      n.childNodes.delete(i)
      return result
      
  raise newException(ENotFoundErr, "Node not found")
    
proc replaceChild*(n: PNode, newChild: PNode, oldChild: PNode): PNode =
  ## Replaces the child node ``oldChild`` with ``newChild`` in the list of children, and returns the ``oldChild`` node.
  
  # Check if newChild is from this nodes document
  if n.FOwnerDocument != newChild.FOwnerDocument:
    raise newException(EWrongDocumentErr, "This node belongs to a different document, use importNode.")
  
  for i in low(n.childNodes)..high(n.childNodes):
    if n.childNodes[i] == oldChild:
      result = n.childNodes[i]
      n.childNodes[i] = newChild
      return result
  
  raise newException(ENotFoundErr, "Node not found")
  
# NamedNodeMap

proc getNamedItem*(NList: Seq[PNode], name: String): PNode =
  ## Retrieves a node specified by ``name``. If this node cannot be found returns ``nil``
  for i in items(nList):
    if i.nodeName() == name:
      return i
  return nil
  
proc getNamedItem*(NList: Seq[PAttr], name: String): PAttr =
  ## Retrieves a node specified by ``name``. If this node cannot be found returns ``nil``
  for i in items(nList):
    if i.nodeName() == name:
      return i
  return nil
      
proc getNamedItemNS*(NList: Seq[PNode], namespaceURI: String, localName: String): PNode =
  ## Retrieves a node specified by ``localName`` and ``namespaceURI``. If this node cannot be found returns ``nil``
  for i in items(nList):
    if i.namespaceURI() == namespaceURI and i.localName() == localName:
      return i
  return nil
  
proc getNamedItemNS*(NList: Seq[PAttr], namespaceURI: String, localName: String): PAttr = 
  ## Retrieves a node specified by ``localName`` and ``namespaceURI``. If this node cannot be found returns ``nil``
  for i in items(nList):
    if i.namespaceURI() == namespaceURI and i.localName() == localName:
      return i
  return nil

proc item*(NList: Seq[PNode], index: Int): PNode =
  ## Returns the ``index`` th item in the map. 
  ## If ``index`` is greater than or equal to the number of nodes in this map, this returns ``nil``.
  if index >= nList.len(): return nil
  else: return nList[index]

proc removeNamedItem*(NList: var Seq[PNode], name: String): PNode =
  ## Removes a node specified by ``name``
  ## Raises the ``ENotFoundErr`` exception, if the node was not found
  for i in low(nList)..high(nList):
    if nList[i].FNodeName == name:
      result = nList[i]
      nList.delete(i)
      return result
  
  raise newException(ENotFoundErr, "Node not found")
  
proc removeNamedItemNS*(NList: var Seq[PNode], namespaceURI: String, localName: String): PNode =
  ## Removes a node specified by local name and namespace URI
  for i in low(nList)..high(nList):
    if nList[i].FLocalName == localName and nList[i].FNamespaceURI == namespaceURI:
      result = nList[i]
      nList.delete(i)
      return result
  
  raise newException(ENotFoundErr, "Node not found")

proc setNamedItem*(NList: var Seq[PNode], arg: PNode): PNode =
  ## Adds ``arg`` as a ``Node`` to the ``NList``
  ## If a node with the same name is already present in this map, it is replaced by the new one.
  if not isNil(nList):
    if nList.len() > 0:
      #Check if newChild is from this nodes document
      if nList[0].FOwnerDocument != arg.FOwnerDocument:
        raise newException(EWrongDocumentErr, "This node belongs to a different document, use importNode.")
  #Exceptions End
  
  var item: PNode = nList.getNamedItem(arg.nodeName())
  if item == nil:
    nList.add(arg)
    return nil
  else:
    # Node with the same name exists
    var index: Int = 0
    for i in low(nList)..high(nList):
      if nList[i] == item:
        index = i
        break
    nList[index] = arg
    return item # Return the replaced node
    
proc setNamedItem*(NList: var Seq[PAttr], arg: PAttr): PAttr =
  ## Adds ``arg`` as a ``Node`` to the ``NList``
  ## If a node with the same name is already present in this map, it is replaced by the new one.
  if not isNil(nList):
    if nList.len() > 0:
      # Check if newChild is from this nodes document
      if nList[0].FOwnerDocument != arg.FOwnerDocument:
        raise newException(EWrongDocumentErr, "This node belongs to a different document, use importNode.")
        
  if arg.FOwnerElement != nil:
    raise newException(EInuseAttributeErr, "This attribute is in use by another element, use cloneNode")
        
  # Exceptions end
  var item: PAttr = nList.getNamedItem(arg.nodeName())
  if item == nil:
    nList.add(arg)
    return nil
  else:
    # Node with the same name exists
    var index: Int = 0
    for i in low(nList)..high(nList):
      if nList[i] == item:
        index = i
        break
    nList[index] = arg
    return item # Return the replaced node
    
proc setNamedItemNS*(NList: var Seq[PNode], arg: PNode): PNode =
  ## Adds a node using its ``namespaceURI`` and ``localName``
  if not isNil(nList):
    if nList.len() > 0:
      # Check if newChild is from this nodes document
      if nList[0].FOwnerDocument != arg.FOwnerDocument:
        raise newException(EWrongDocumentErr, "This node belongs to a different document, use importNode.")
  #Exceptions end
        
  var item: PNode = nList.getNamedItemNS(arg.namespaceURI(), arg.localName())
  if item == nil:
    nList.add(arg)
    return nil
  else:
    # Node with the same name exists
    var index: Int = 0
    for i in low(nList)..high(nList):
      if nList[i] == item:
        index = i
        break
    nList[index] = arg
    return item # Return the replaced node
    
proc setNamedItemNS*(NList: var Seq[PAttr], arg: PAttr): PAttr =
  ## Adds a node using its ``namespaceURI`` and ``localName``
  if not isNil(nList):
    if nList.len() > 0:
      # Check if newChild is from this nodes document
      if nList[0].FOwnerDocument != arg.FOwnerDocument:
        raise newException(EWrongDocumentErr, "This node belongs to a different document, use importNode.")
        
  if arg.FOwnerElement != nil:
    raise newException(EInuseAttributeErr, "This attribute is in use by another element, use cloneNode")
        
  # Exceptions end
  var item: PAttr = nList.getNamedItemNS(arg.namespaceURI(), arg.localName())
  if item == nil:
    nList.add(arg)
    return nil
  else:
    # Node with the same name exists
    var index: Int = 0
    for i in low(nList)..high(nList):
      if nList[i] == item:
        index = i
        break
    nList[index] = arg
    return item # Return the replaced node
    
# CharacterData - Decided to implement this, 
# Didn't add the procedures, because you can just edit .data

# Attr
# Attributes
proc name*(a: PAttr): String =
  ## Returns the name of the Attribute

  return a.FName
  
proc specified*(a: PAttr): Bool =
  ## Specifies whether this attribute was specified in the original document

  return a.FSpecified
  
proc ownerElement*(a: PAttr): PElement = 
  ## Returns this Attributes owner element

  return a.FOwnerElement

# Element
# Attributes

proc tagName*(el: PElement): String =
  ## Returns the Element Tag Name

  return el.FTagName

# Procedures
proc getAttribute*(el: PElement, name: String): String =
  ## Retrieves an attribute value by ``name``
  var attribute = el.attributes.getNamedItem(name)
  if attribute != nil:
    return attribute.value
  else:
    return nil

proc getAttributeNS*(el: PElement, namespaceURI: String, localName: String): String =
  ## Retrieves an attribute value by ``localName`` and ``namespaceURI``
  var attribute = el.attributes.getNamedItemNS(namespaceURI, localName)
  if attribute != nil:
    return attribute.value
  else:
    return nil
    
proc getAttributeNode*(el: PElement, name: String): PAttr =
  ## Retrieves an attribute node by ``name``
  ## To retrieve an attribute node by qualified name and namespace URI, use the `getAttributeNodeNS` method
  return el.attributes.getNamedItem(name)

proc getAttributeNodeNS*(el: PElement, namespaceURI: String, localName: String): PAttr =
  ## Retrieves an `Attr` node by ``localName`` and ``namespaceURI``
  return el.attributes.getNamedItemNS(namespaceURI, localName)

proc getElementsByTagName*(el: PElement, name: String): Seq[PNode] =
  ## Returns a `NodeList` of all descendant `Elements` of ``el`` with a given tag ``name``,
  ## in the order in which they are encountered in a preorder traversal of this `Element` tree
  ## If ``name`` is `*`, returns all descendant of ``el``
  result = el.findNodes(name)

proc getElementsByTagNameNS*(el: PElement, namespaceURI: String, localName: String): Seq[PNode] =
  ## Returns a `NodeList` of all the descendant Elements with a given
  ## ``localName`` and ``namespaceURI`` in the order in which they are
  ## encountered in a preorder traversal of this Element tree
  result = el.findNodesNS(namespaceURI, localName)

proc hasAttribute*(el: PElement, name: String): Bool =
  ## Returns ``true`` when an attribute with a given ``name`` is specified 
  ## on this element , ``false`` otherwise. 
  return el.attributes.getNamedItem(name) != nil

proc hasAttributeNS*(el: PElement, namespaceURI: String, localName: String): Bool =
  ## Returns ``true`` when an attribute with a given ``localName`` and
  ## ``namespaceURI`` is specified on this element , ``false`` otherwise 
  return el.attributes.getNamedItemNS(namespaceURI, localName) != nil

proc removeAttribute*(el: PElement, name: String) =
  ## Removes an attribute by ``name``
  for i in low(el.attributes)..high(el.attributes):
    if el.attributes[i].FName == name:
      el.attributes.delete(i)
      
proc removeAttributeNS*(el: PElement, namespaceURI: String, localName: String) =
  ## Removes an attribute by ``localName`` and ``namespaceURI``
  for i in low(el.attributes)..high(el.attributes):
    if el.attributes[i].FNamespaceURI == namespaceURI and 
        el.attributes[i].FLocalName == localName:
      el.attributes.delete(i)
  
proc removeAttributeNode*(el: PElement, oldAttr: PAttr): PAttr =
  ## Removes the specified attribute node
  ## If the attribute node cannot be found raises ``ENotFoundErr``
  for i in low(el.attributes)..high(el.attributes):
    if el.attributes[i] == oldAttr:
      result = el.attributes[i]
      el.attributes.delete(i)
      return result
  
  raise newException(ENotFoundErr, "oldAttr is not a member of el's Attributes")

proc setAttributeNode*(el: PElement, newAttr: PAttr): PAttr =
  ## Adds a new attribute node, if an attribute with the same `nodeName` is
  ## present, it is replaced by the new one and the replaced attribute is
  ## returned, otherwise ``nil`` is returned.
  
  # Check if newAttr is from this nodes document
  if el.FOwnerDocument != newAttr.FOwnerDocument:
    raise newException(EWrongDocumentErr, 
      "This node belongs to a different document, use importNode.")
        
  if newAttr.FOwnerElement != nil:
    raise newException(EInuseAttributeErr, 
      "This attribute is in use by another element, use cloneNode")
  # Exceptions end
  
  if isNil(el.attributes): el.attributes = @[]
  return el.attributes.setNamedItem(newAttr)
  
proc setAttributeNodeNS*(el: PElement, newAttr: PAttr): PAttr =
  ## Adds a new attribute node, if an attribute with the localName and 
  ## namespaceURI of ``newAttr`` is present, it is replaced by the new one
  ## and the replaced attribute is returned, otherwise ``nil`` is returned.
  
  # Check if newAttr is from this nodes document
  if el.FOwnerDocument != newAttr.FOwnerDocument:
    raise newException(EWrongDocumentErr, 
      "This node belongs to a different document, use importNode.")
        
  if newAttr.FOwnerElement != nil:
    raise newException(EInuseAttributeErr, 
      "This attribute is in use by another element, use cloneNode")
  # Exceptions end
  
  if isNil(el.attributes): el.attributes = @[]
  return el.attributes.setNamedItemNS(newAttr)

proc setAttribute*(el: PElement, name: String, value: String) =
  ## Adds a new attribute, as specified by ``name`` and ``value``
  ## If an attribute with that name is already present in the element, its 
  ## value is changed to be that of the value parameter
  ## Raises the EInvalidCharacterErr if the specified ``name`` contains 
  ## illegal characters
  var attrNode = el.FOwnerDocument.createAttribute(name)
  # Check if name contains illegal characters
  if illegalChars in name:
    raise newException(EInvalidCharacterErr, "Invalid character")
    
  discard el.setAttributeNode(attrNode)
  # Set the info later, the setAttributeNode checks
  # if FOwnerElement is nil, and if it isn't it raises an exception
  attrNode.FOwnerElement = el
  attrNode.FSpecified = true
  attrNode.value = value
  
proc setAttributeNS*(el: PElement, namespaceURI, localName, value: String) =
  ## Adds a new attribute, as specified by ``namespaceURI``, ``localName`` 
  ## and ``value``.
  
  # Check if name contains illegal characters
  if illegalChars in namespaceURI or illegalChars in localName:
    raise newException(EInvalidCharacterErr, "Invalid character")
    
  var attrNode = el.FOwnerDocument.createAttributeNS(namespaceURI, localName)
    
  discard el.setAttributeNodeNS(attrNode)
  # Set the info later, the setAttributeNode checks
  # if FOwnerElement is nil, and if it isn't it raises an exception
  attrNode.FOwnerElement = el
  attrNode.FSpecified = true
  attrNode.value = value

# Text  
proc splitData*(TextNode: PText, offset: Int): PText =
  ## Breaks this node into two nodes at the specified offset, 
  ## keeping both in the tree as siblings.
  
  if offset > textNode.data.len():
    raise newException(EIndexSizeErr, "Index out of bounds")
  
  var left: String = textNode.data.substr(0, offset)
  textNode.data = left
  var right: String = textNode.data.substr(offset, textNode.data.len())
  
  if textNode.FParentNode != nil:
    for i in low(textNode.FParentNode.childNodes)..high(textNode.FParentNode.childNodes):
      if textNode.FParentNode.childNodes[i] == textNode:
        var newNode: PText = textNode.FOwnerDocument.createTextNode(right)
        textNode.FParentNode.childNodes.insert(newNode, i)
        return newNode
  else:
    var newNode: PText = textNode.FOwnerDocument.createTextNode(right)
    return newNode


# ProcessingInstruction
proc target*(PI: PProcessingInstruction): String =
  ## Returns the Processing Instructions target

  return pi.FTarget

    
# --Other stuff--
# Writer
proc addEscaped(s: String): String = 
  result = ""
  for c in items(s):
    case c
    of '<': result.add("&lt;")
    of '>': result.add("&gt;")
    of '&': result.add("&amp;")
    of '"': result.add("&quot;")
    else: result.add(c)

proc nodeToXml(n: PNode, indent: Int = 0): String =
  result = repeatChar(indent, ' ') & "<" & n.nodeName
  for i in items(n.Attributes):
    result.add(" " & i.name & "=\"" & addEscaped(i.value) & "\"")
  
  if n.childNodes.len() == 0:
    result.add("/>") # No idea why this doesn't need a \n :O
  else:
    # End the beginning of this tag
    result.add(">\n")
    for i in items(n.childNodes):
      case i.nodeType
      of ElementNode:
        result.add(nodeToXml(i, indent + 2))
      of TextNode:
        result.add(repeatChar(indent * 2, ' '))
        result.add(addEscaped(i.nodeValue))
      of CDataSectionNode:
        result.add(repeatChar(indent * 2, ' '))
        result.add("<![CDATA[" & i.nodeValue & "]]>")
      of ProcessingInstructionNode:
        result.add(repeatChar(indent * 2, ' '))
        result.add("<?" & PProcessingInstruction(i).target & " " &
                          PProcessingInstruction(i).data & " ?>")
      of CommentNode:
        result.add(repeatChar(indent * 2, ' '))
        result.add("<!-- " & i.nodeValue & " -->")
      else:
        continue
      result.add("\n")
    # Add the ending tag - </tag>
    result.add(repeatChar(indent, ' ') & "</" & n.nodeName & ">")

proc `$`*(doc: PDocument): String =
  ## Converts a PDocument object into a string representation of it's XML
  result = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n"
  result.add(nodeToXml(doc.documentElement))
