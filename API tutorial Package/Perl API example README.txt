                         README file for ITRS API examples
                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This requires perl 5.8.0

You can check your perl version with 

    perl -v

The path for perl is set to /usr/bin/perl in each of the scripts, this may need 
to be amended to suit your install.


To install RPC-XML
~~~~~~~~~~~~~~~~~~

Un-tar RPC-XML-0.67.tar which will create the directory RPC-XML-0.67

Change to the directory RPC-XML-0.67 and follow the README, which says

    This package is set up to configure and build like a typical Perl
    extension.
    To build:

        perl Makefile.PL
        make && make test

    If RPC::XML passes all tests, then:

        make install

    You may need super-user access to install.
  

Note:

If you cannot fully install RPC-XML, (e.g. you don't have root access) it's 
probably sufficient to untar RPC-XML-0.67.tar in the same directory as these 
scripts.  Then in each of the scripts add the line 

    use lib "./RPC-XML-0.67/lib";

before the 

    use RPC::XML 

entry


To set-up and run the API example
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The names in the scripts must match the names of the managed entity and samplers
which are being used, easies approach is to add a managed entity for the API 
plug-in of 

<managedEntity name="ME_API">
    <probe ref="insert probe name"></probe>
    <sampler ref="API_Sampler"></sampler>
</managedEntity>

and a sampler of

<sampler name="API_Sampler">
    <plugin>
        <api></api>
    </plugin>
</sampler>


Once configured run the script run_api_example.sh giving it the hostname and port
of the netprobe to which you want it to send updates

run_api_example.sh itrsrh 7036



To set-up and run an API Streams example
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add an API_StreamsSampler

<sampler name="API_StreamsSampler">
    <plugin>
        <api-streams>
            <streams>
                <stream>
                    <data>myteststream</data>
                </stream>
            </streams>
            <createView>
                <data>true</data>
            </createView>
        </api-streams>
    </plugin>
</sampler>


Add FKM to pick up the stream

<sampler name="API_FKM">
    <plugin>
        <fkm>
            <display>
                <triggerMode>MULTIPLE_GROUPED_TRIGGER</triggerMode>
            </display>
            <files>
                <file>
                    <source>
                        <stream>
                            <data>ME_API.API_StreamsSampler.myteststream</data>
                        </stream>
                    </source>
                    <contentType>
                        <data>TEXT</data>
                    </contentType>
                    <failTable>
                        <data>
                            <keys>
                                <key>
                                    <setKey>
                                        <match>
                                            <searchString>
                                                <data>error</data>
                                            </searchString>
                                        </match>
                                    </setKey>
                                </key>
                            </keys>
                        </data>
                    </failTable>
                    <warningTable>
                        <data>
                            <keys>
                                <key>
                                    <setKey>
                                        <match>
                                            <searchString>
                                                <data>warning</data>
                                            </searchString>
                                        </match>
                                    </setKey>
                                </key>
                            </keys>
                        </data>
                    </warningTable>
                </file>
            </files>
        </fkm>
    </plugin>
</sampler>


And add the new API_StreamsSampler and API_FKM samplers to the managed entity

<managedEntity name="ME_API">
    <probe ref="itrsrh"></probe>
    <sampler ref="API_Sampler"></sampler>
    <sampler ref="API_StreamsSampler"></sampler>
    <sampler ref="API_FKM"></sampler>
</managedEntity>

Now run the streamsapi_example.pl specifying host and port of the netprobe to 
which you want it to send updates

streamsapi_example.pl itrsrh 7036
