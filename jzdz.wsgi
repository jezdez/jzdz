import os
os.environ['DJANGO_SETTINGS_MODULE'] = 'jzdz.settings'

import django.core.handlers.wsgi
application = django.core.handlers.wsgi.WSGIHandler()