--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
-- Blog
    match "b/*" $ do
        let postCtx =
                dateField "date" "%B %e, %Y" `mappend`
                defaultContext
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html" postCtx
            >>= loadAndApplyTemplate "templates/base.html" postCtx
            >>= relativizeUrls

    match "blog.html" $ do
        route   $ constRoute "b/index.html"
        compile $ do
            posts <- recentFirst =<< loadAll "b/*"
            let postCtx =
                    dateField "date" "%B %e, %Y" `mappend`
                    defaultContext
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Blog"                `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/base.html" indexCtx
                >>= relativizeUrls

-- Projects
    match "r/**" $ do
        route   idRoute
        compile copyFileCompiler

    match "p/*" $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/project.html" defaultContext
            >>= relativizeUrls

    match "projects.html" $ do
        route   $ constRoute "p/index.html"
        compile $ do
            projects <- loadAll "p/*"
            let indexCtx =
                    listField "projects" defaultContext (return projects) `mappend`
                    constField "title" "Projects"                         `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/base.html" indexCtx
                >>= relativizeUrls

--  Pages
    match "about.markdown" $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/base.html" defaultContext
            >>= relativizeUrls

    match "contact.markdown" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/base.html" defaultContext
            >>= relativizeUrls

    match "404.html" $ do
        route   idRoute
        compile copyFileCompiler

-- Styles, structure, etc.
    match "images/**" $ do
        route   idRoute
        compile copyFileCompiler

    match "fonts/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "js/**" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/**" $ do
        route   idRoute
        compile compressCssCompiler

    match "templates/*" $ compile templateBodyCompiler
