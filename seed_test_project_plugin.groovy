job('auto_test_project_plugin') {
    disabled(true)
  	properties{
    	templateProperty()
    }
    parameters {
        stringParam('INPUT_PARAM1', 'DEFAULT')
    }  
    scm {
        git('git://github.com/quidryan/aws-sdk-test.git')
    }
    steps {
        shell('''
echo "executing template project changed!!!!!!"
echo "input param-> $INPUT_PARAM1"
echo "end"
ls -la 
''')
    }
}

