//
//  LinkedList.c
//  INGI1113m1
//
//  Created by Guillaume Derval on 20/09/13.
//  Copyright (c) 2013 Guillaume Derval. All rights reserved.
//
#include <stdlib.h>
#include <stdio.h>
#include "LinkedList.h"

/**
 * Value col
 */
ValueColLinkedList* createValueColLinkedList()
{
    ValueColLinkedList* list = (ValueColLinkedList*)malloc(sizeof(ValueColLinkedList));
    if(!list)
        return NULL;
    list->first = NULL;
    list->last = NULL;
    return list;
}

void freeValueColLinkedList(ValueColLinkedList* list)
{
    if(!list)
        return;
    ValueColLinkedListNode* elem = list->first;
    while(elem)
    {
        ValueColLinkedListNode* next = elem->next;
        free(elem);
        elem = next;
    }
    free(list);
}

void pushBackValueCol(ValueColLinkedList* list, int element, int column)
{
    if(!list)
        return;
    ValueColLinkedListNode* elem = (ValueColLinkedListNode*)malloc(sizeof(ValueColLinkedListNode));
    if(!elem)
        return;
    
    elem->value = element;
    elem->column = column;
    elem->next = NULL;
    if(list->last == NULL)
    {
        list->first = elem;
        list->last = elem;
    }
    else
    {
        list->last->next = elem;
        list->last = elem;
    }
}