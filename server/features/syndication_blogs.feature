Feature: Syndication Blog Resource

    Scenario: List blogs
        Given "themes"
        """
        [{"name": "forest"}]
        """
        Given "blogs"
        """
        [
            {
                "title": "testBlog",
                "blog_status": "open",
                "syndication_enabled": true,
                "blog_preferences": {"theme": "forest", "language": "fr"}
            },
            {
                "title": "testBlog2",
                "blog_status": "open",
                "syndication_enabled": false,
                "blog_preferences": {"theme": "forest", "language": "fr"}
            },
            {
                "title": "testBlog3",
                "blog_status": "open",
                "syndication_enabled": true,
                "blog_preferences": {"theme": "forest", "language": "fr"}
            }
        ]
        """
        Given config consumer api_key
        When we get "/syndication/blogs/"
        Then we get list with 3 items

    Scenario: Create blog syndication
        Given "themes"
        """
        [{"name": "forest"}]
        """
        Given "blogs" as item list
        """
        [
            {
                "title": "Producer Blog",
                "blog_status": "open",
                "syndication_enabled": true,
                "blog_preferences": {"theme": "forest", "language": "fr"}
            },
            {
                "title": "Consumer Blog",
                "blog_status": "open",
                "syndication_enabled": false,
                "blog_preferences": {"theme": "forest", "language": "fr"}
            }
        ]
        """
        Given config consumer api_key
        When we post to "/syndication/blogs/#blogs[0]._id#/syndicate/" with success
        """
        {
            "consumer_blog_id": "#blogs[1]._id#",
            "start_date": "2016-12-01T14:00:00+0000"
        }
        """
        Then we get response code 201
