--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Data.List
import           Hakyll
import           System.FilePath.Posix
import           System.File.Tree
import           System.Directory


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
-- Blog
    match "b/*" $ do
        let postCtx =
                dateField "date" "%B %e, %Y" `mappend`
                defaultContext
        route $ cleanRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html" postCtx
            >>= loadAndApplyTemplate "templates/base.html" postCtx
            >>= relativizeUrls
            >>= cleanIndexUrls

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
                >>= cleanIndexUrls

-- Projects
    match "node_modules/**" $ do
        preprocess $ createDirectory "_site"
        preprocess $ getDirectory "node_modules"
            >>= copyTo_ "_site/r"

    match "p/*" $ do
        route   $ cleanRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/project.html" defaultContext
            >>= relativizeUrls
            >>= cleanIndexUrls

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
                >>= cleanIndexUrls

--  Pages
    match "about.markdown" $ do
        route   $ cleanRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/base.html" defaultContext
            >>= relativizeUrls
            >>= cleanIndexUrls

    match "contact.markdown" $ do
        route $ cleanRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/base.html" defaultContext
            >>= relativizeUrls
            >>= cleanIndexUrls

    match "404.html" $ do
        route   cleanRoute
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

----
-- .html to /index.html router
----

cleanRoute :: Routes
cleanRoute = customRoute createIndexRoute
  where
    createIndexRoute ident = takeDirectory p </> takeBaseName p </> "index.html"
                            where p = toFilePath ident

----
-- index.html strippers
----

cleanIndexUrls :: Item String -> Compiler (Item String)
cleanIndexUrls = return . fmap (withUrls cleanIndex)

cleanIndexHtmls :: Item String -> Compiler (Item String)
cleanIndexHtmls = return . fmap (replaceAll pattern replacement)
    where
      pattern = "/index.html"
      replacement = const "/"

cleanIndex :: String -> String
cleanIndex url
    | idx `isSuffixOf` url = take (length url - length idx) url
    | otherwise            = url
  where idx = "index.html"
