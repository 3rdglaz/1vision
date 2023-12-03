package recipe.one.exception

import recipe.one.validation.handler.Notification

class NotificationException(message: String, notification: Notification) :
    DomainException(message, notification.getErrors())