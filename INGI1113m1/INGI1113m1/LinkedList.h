//
//  LinkedList.h
//  INGI1113m1
//
//  Created by Guillaume Derval on 20/09/13.
//  Copyright (c) 2013 Guillaume Derval. All rights reserved.
//

#ifndef INGI1113m1_LinkedList_h
#define INGI1113m1_LinkedList_h

/**
 * Simple linked list with contains informations of an element of the sparse matrix.
 */
struct ValueColLinkedListNode
{
    int value;
    int column;
    struct ValueColLinkedListNode* next;
};
typedef struct ValueColLinkedListNode ValueColLinkedListNode;

struct ValueColLinkedList
{
    struct ValueColLinkedListNode* first;
    struct ValueColLinkedListNode* last;
};
typedef struct ValueColLinkedList ValueColLinkedList;

ValueColLinkedList* createValueColLinkedList();
void freeValueColLinkedList(ValueColLinkedList* list);
void pushBackValueCol(ValueColLinkedList* list, int element, int column);
#endif
